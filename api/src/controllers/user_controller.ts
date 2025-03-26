import { Request, RequestHandler, response, Response } from 'express';
import User from '../models/user';

export const getUser: RequestHandler = async (req: Request, res: Response) => {
  let id = req.session.userId;
  
  const user = await User.findByPk(id);

  res.status(200).json({
    user: {
      id: user?.id,
      name: user?.name,
      email: user?.email,
      createdAt: user?.createdAt,
      image_url: user?.image_url
    },
    msg: 'Already logged in!',
  });
}

