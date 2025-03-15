import { Request, RequestHandler, Response } from 'express';
import Posts from '../models/post';
import { v4 as uuidv4 } from 'uuid';

export const getAllPost: RequestHandler = async (req: Request, res: Response) => {
  const posts = await Posts.findAll();

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
  
  const posts = await Posts.findAll({
    where: whereClause
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
  const { subject, title, content, image_url } = req.body;
  let id = req.session.userId as string;

  if (!subject || !content) {
    res.status(400).send({ message: 'Please fill all fields' })
    return;
  }

  await Posts.create({
    id: uuidv4(),
    user_id: id,
    subject: subject,
    title: title ?? '',
    content: content,
    image_url: image_url ?? ''
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