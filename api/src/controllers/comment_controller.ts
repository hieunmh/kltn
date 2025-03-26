import { Request, RequestHandler, Response } from 'express';
import { v4 as uuidv4 } from 'uuid';
import Comment from '../models/comment';
import User from '../models/user';

export const createComment: RequestHandler = async (req: Request, res: Response) => {
  const { post_id, content, image_url } = req.body;
  const user_id = req.session.userId as string;

  if (!post_id || !content) {
    res.status(400).send({ message: 'Please fill all fields' })
    return;
  }

  await Comment.create({
    id: uuidv4(),
    post_id: post_id,
    user_id: user_id,
    content: content,
    image_url: image_url ?? ''
  }).then((comment) => {
    res.status(201).send({
      msg: 'Create comment successfully!',
      comment: comment
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}

export const getAllCommentByPost: RequestHandler = async (req: Request, res: Response) => {
  const { post_id } = req.query;

  await Comment.findAll({
    where: { post_id: post_id as string },
    order: [['createdAt', 'ASC']],
    include: [
      {
        model: User,
        as: 'user',
        attributes: ['id', 'name', 'email', 'image_url']
      },
    ]
  }).then((comments) => {
    res.status(200).send({
      comments: comments
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}

export const deleteComment: RequestHandler = async (req: Request, res: Response) => {
  const { comment_id } = req.body;

  await Comment.destroy({
    where: { id: comment_id }
  }).then(() => {
    res.status(200).send({ msg: 'Delete comment successfully!' });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}