import { Request, RequestHandler, response, Response } from 'express';
import User from '../models/user';
import { supabase } from '../config/supabase';
import path from 'path';

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

export const uploadUserImage: RequestHandler = async (req: Request, res: Response) => {

  const user_id = req.session.userId;
  const user = await User.findByPk(user_id);

  try {
    if (!req.file) {
      res.status(400).json({ message: 'Please upload an image' });
      return;
    }

    const filename = `${user_id}_avatar${path.extname(req.file.originalname)}`;

    const { data, error } = await supabase.storage.from('userimages').upload(
      '/' + filename, 
      req.file.buffer, {
        cacheControl: '3600',
        upsert: true,
        contentType: req.file.mimetype
      }
    )

    if (error) {
      res.status(500).json({ error: error });
      return;
    }

    user!.image_url = data.fullPath;
    await user!.save();

    res.status(200).json({
      msg: 'Image uploaded successfully!',
      user: {
        id: user!.id,
        name: user!.name,
        email: user!.email,
        image_url: user!.image_url
      }
    })
  }
  catch (error) {
    res.status(500).json({  error: error })
  }
}

