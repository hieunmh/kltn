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
    include: [
      {
        model: Comment,
        as: 'comments',
        attributes: [
          'id', 'user_id', 'post_id', 'content', 'createdAt', 'updatedAt'
        ],
        include: [{
          model: Users,
          as: 'user',
          attributes: ['id', 'name', 'email', 'image_url']
        }]
      },
      { 
        model: Users,
        as: 'user',
        attributes: ['id', 'name', 'email', 'image_url']
      }
    ],
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

export const updatePost: RequestHandler = async (req: Request, res: Response) => {
  const { content, post_id, image_path, is_delete_image } = req.body;
  let user_id = req.session.userId as string;

  if (!content) {
    res.status(400).send({ message: 'Please fill all fields 123' })
    return;
  }

  let image_url = image_path;

  console.log(is_delete_image == 'true');
  console.log(req.body);

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

    await supabase.storage.from('postimages').remove([image_path.replace('postimages/', '')]);

    if (data) image_url = data.fullPath;

    if (error) {
      res.status(500).send({ error: error });
      return;
    }
  } else if (is_delete_image == 'true') {
    await supabase.storage.from('postimages').remove([image_path.replace('postimages/', '')]);
  }

  await Post.update({
    content: content,
    image_url: is_delete_image == 'true' ? '' : image_url
  }, { where: { id: post_id, user_id: user_id } }).then(
    (post) => {
      res.status(200).send({
        msg: 'Post updated successfully!',
        post: {
          id: post_id,
          image_url: is_delete_image == 'true' ? '' : image_url,
          content: content,
        }
      })
    }
  ).catch((e) => {
    res.status(400).send({ message: e });
  })
}


export const createPost: RequestHandler = async (req: Request, res: Response) => {
  const { subject, content } = req.body;
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
    content: content,
    image_url: image_url
  }).then((post) => {
    res.status(201).send({
      msg: 'Post created successfully!',
      post: {
        id: post.id,
        user_id: post.user_id,
        subject: post.subject,
        content: post.content,
        image_url: post.image_url ?? '',
        createdAt: post.createdAt,
        updatedAt: post.updatedAt
      }
    })
  })
}

export const deletePost: RequestHandler = async (req: Request, res: Response) => {
  const { post_id, image_path } = req.body;
  const user_id = req.session.userId as string;

  const { data, error } = await supabase.storage.from('postimages').remove([image_path.replace('postimages/', '')])

  if (error) {
    res.status(500).send({ error: error });
    return;
  }

  await Post.destroy({
    where: { id: post_id, user_id: user_id }
  }).then(() => {
    res.status(200).send({ msg: 'Delete post successfully!' });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}