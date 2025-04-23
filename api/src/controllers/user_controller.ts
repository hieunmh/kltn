import { Request, RequestHandler, response, Response } from 'express';
import User from '../models/user';
import { supabase } from '../config/supabase';
import path from 'path';
import bcrypt from 'bcrypt';


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

    const filename = `${user_id}_${Date.now()}_${path.extname(req.file.originalname)}`;

    if (user && user.image_url) {
      const imagePath = user.image_url.replace('userimages/', '');
      const { error: deleteError } = await supabase.storage.from('userimages').remove([imagePath]);
      if (deleteError) {
        console.error('Error deleting image:', deleteError);
      }
    }

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

export const updateUserInfo: RequestHandler = async (req: Request, res: Response) => {
  const { newName, newEmail } = req.body;
  const user_id = req.session.userId;

  const user = await User.findByPk(user_id);

  if (!user) {
    res.status(400).json({ message: 'User not found!' });
    return;
  }

  if (newName) user.name = newName;

  if (newEmail) {
    const existingUser = await User.findOne({ where: { email: newEmail } });

    if (existingUser && existingUser?.email === user.email) {
      user.email = newEmail;
    } else {
      res.status(400).json({ message: 'Email already in use!' });
      return;
    }
  }

  await user!.save();

  res.status(200).json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      image_url: user.image_url
    },
    msg: 'Update user info successfully!'
  });
}

export const changePassword: RequestHandler = async (req: Request, res: Response) => {
  const { oldPassword, newPassword } = req.body;
  const user_id = req.session.userId;

  const user = await User.findByPk(user_id);

  if (!user) {
    res.status(400).json({ message: 'User not found!' });
    return;
  }

  if (!bcrypt.compareSync(oldPassword, user.password)) {
    res.status(500).json({ message: 'Old password not match!' });
    return;
  }

 


  user.password = bcrypt.hashSync(newPassword, 10);
  user.save();

  res.status(200).json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      image_url: user.image_url
    },
    msg: 'Change password successfully!'
  });
}