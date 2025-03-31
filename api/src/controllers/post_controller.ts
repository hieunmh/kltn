import { Request, RequestHandler, Response } from 'express';
import Post from '../models/post';
import { v4 as uuidv4 } from 'uuid';
import Users from '../models/user';
import { Sequelize } from 'sequelize-typescript';
import Comment from '../models/comment';
import path from 'path';
import { supabase } from '../config/supabase';

export const getAllPost: RequestHandler = async (req: Request, res: Response) => {
  const posts = await Post.findAll();

  res.status(200).send({
    posts: posts
  });
}

export const getPostByCondition: RequestHandler = async (req: Request, res: Response) => {
  const { subject, user_id } = req.query;

  const whereClause: any = {};

  if (subject) {
    whereClause.subject = subject as string;
  }
  
  if (user_id) {
    whereClause.user_id = user_id as string;
  }
  
  const posts = await Post.findAll({
    where: whereClause,
    attributes: {
      include: [
        [Sequelize.fn('COUNT', Sequelize.col('comments.id')), 'comment_count']
      ]
    },
    include: [
      {
        model: Comment,
        attributes: []
      },
      { 
        model: Users,
        as: 'user',
        attributes: ['id', 'name', 'email', 'image_url']
      }
    ],
    group: ['Post.id', 'user.id'],
    order: [['createdAt', 'DESC']]
  });

  if (posts.length == 0) {
    res.status(404).send({ message: 'No post found!' });
    return;
  }

  res.status(200).send({
    posts: posts
  });
}


export const createPost: RequestHandler = async (req: Request, res: Response) => {
  const { subject, title, content } = req.body;
  let user_id = req.session.userId as string;

  if (!subject || !content) {
    res.status(400).send({ message: 'Please fill all fields' })
    return;
  }

  let image_url = ''

  if (req.file) {
    const filename = `post_${Date.now()}_${req.file.originalname}`;
    const { data, error } = await supabase.storage.from('postimages').upload(
      `/${user_id}/${filename}`, 
      req.file.buffer, {
        cacheControl: '3600',
        upsert: false,
        contentType: req.file.mimetype
      }
    )

    if (data) image_url = data.fullPath;

    if (error) {
      res.status(500).send({ error: error });
      return;
    }
  }

  await Post.create({
    id: uuidv4(),
    user_id: user_id,
    subject: subject,
    title: title ?? '',
    content: content,
    image_url: image_url
  }).then((post) => {
    res.status(201).send({
      msg: 'Post created successfully!',
      post: {
        id: post.id,
        user_id: post.user_id,
        subject: post.subject,
        title: post.title,
        content: post.content,
        image_url: post.image_url ?? '',
        createdAt: post.createdAt,
        updatedAt: post.updatedAt
      }
    })
  })
}