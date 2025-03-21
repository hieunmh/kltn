import { Request, RequestHandler, Response } from 'express';
import { v4 as uuidv4 } from 'uuid';
import Chat from '../models/chat';
import Message from '../models/message';

export const createChat: RequestHandler = async (req: Request, res: Response) => {
  const user_id = req.session.userId as string;
  const { chat_name } = req.body;

  await Chat.create({
    id: uuidv4(),
    user_id: user_id,
    name: chat_name ?? ''
  }).then((chat) => {
    res.status(201).send({
      chat: chat
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}

export const updateChat: RequestHandler = async (req: Request, res: Response) => {
  const { chat_id, chat_name } = req.body;

  if (!chat_id || !chat_name) {
    res.status(400).send({ message: 'Please fill all fields' })
    return;
  }

  await Chat.update({
    name: chat_name
  }, {
    where: { id: chat_id }
  }).then((chat) => {
    res.status(200).send({
      msg: 'Update chat successfully!'
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}

export const getAllChatByUser: RequestHandler = async (req: Request, res: Response) => {
  const user_id = req.session.userId as string;

  await Chat.findAll({
    where: { user_id: user_id },
  }).then((chats) => {
    res.status(200).send({
      chats: chats
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}

export const getChatbyId: RequestHandler = async (req: Request, res: Response) => {
  const { chat_id } = req.query;

  await Chat.findByPk(chat_id as string, {
    include: [{
      model: Message,
      as: 'messages',
      attributes: ['id', 'role', 'message', 'createdAt', 'updatedAt'],
      order: [['createdAt', 'ASC']]
    }]
  }).then((chat) => {
    if (!chat) {
      res.status(404).send({ message: 'Chat not found!' });
      return;
    }

    res.status(200).send({
      chat: chat
    });
  }).catch((e) => {
    res.status(400).send({ message: e });
  })
}
