import { Request, RequestHandler, Response } from 'express';
import Message from '../models/message';
import { v4 as uuidv4 } from 'uuid';

export const createMessage: RequestHandler = async (req: Request, res: Response) => {
  const { chat_id, role, message } = req.body;

  if (!chat_id || !role || !message) {
    res.status(400).send({ message: 'Please fill all fields' })
    return;
  }

  await Message.create({
    id: uuidv4(),
    chat_id: chat_id,
    role: role,
    message: message
  }).then((message) => {
    res.status(201).send({
      msg: 'Create message successfully!',
      message: message
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}


export const getAllMessage: RequestHandler = async (req: Request, res: Response) => {
  const { chat_id } = req.query;

  await Message.findAll({
    where: { chat_id: chat_id as string },
    order: [['createdAt', 'ASC']]
  }).then((messages) => {
    res.status(200).send({
      messages: messages
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}