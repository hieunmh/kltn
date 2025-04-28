import { Request, RequestHandler, Response } from 'express';
import User from '../models/user';
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcrypt';
import { UserType } from '../types/types';
import nodemailer from 'nodemailer';
import dotenv from 'dotenv';

dotenv.config();

const transporter = nodemailer.createTransport({
  host: 'sandbox.smtp.mailtrap.io',
  port: 2525,
  auth: { user: process.env.MAILTRAP_USER, pass: process.env.MAILTRAP_PW }
})


export const signup: RequestHandler = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  if (!email || ! password) {
    res.status(400).json({ message: 'Please fill all fields' });
    return;
  }

  await User.create({
    id: uuidv4(),
    name: '',
    email: email,
    password: bcrypt.hashSync(password, 10)
  }).then((user: UserType) => {
    req.session.userId = user.id;

    res.status(201).json({
      user: {
        id: user.id,
        name: user.name ?? '',
        email: user.email,
        createdAt: user.createdAt ?? '',
        image_url: user.image_url 
      },
      msg: 'User created successfully!'
    });
  }).catch(e => {
    res.status(400).json({
      msg: e.errors[0].message
    })
  })
}

export const signin: RequestHandler = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  if (!email || !password) {
    res.status(400).json({ message: 'Please fill all fields' });
    return;
  }

  const user = await User.findOne({
    attributes: ['id', 'name', 'email', 'password', 'createdAt', 'image_url'],
    where: { email: email}
  });

  if (!user) {
    res.status(400).json({ message: 'User not found!' });
    return;
  }

  if (!bcrypt.compareSync(password, user.password)) {
    res.status(400).json({ message: 'Invalid credentials!' });
    return;
  } 
  req.session.userId = user.id;
  req.session.save();
  
  
  res.status(200).json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      created_at: user.createdAt,
      image_url: user.image_url
    },
    msg: 'Sign in successfully!'
  });
}

export const signout: RequestHandler = async (req: Request, res: Response) => {
  if (!req.session.userId) {
    res.status(400).json({ msg: 'No user signed in!' }); 
    return;
  }

  req.session.destroy((err) => {
    if (err) {
      return res.status(500).json({ msg: 'Internal error!' });
    }
    
    res.clearCookie('sid');
    res.status(200).json({ msg: 'Sign out successfully!' });
  });

};

export const forgotPassword: RequestHandler = async (req: Request, res: Response) => {
  const { email } = req.body;

  if (!email) {
    res.status(400).json({ msg: 'Please enter you email!' });
    return;
  }

  const user = await User.findOne({ where: { email: email }});

  if (!user) {
    res.status(404).json({ msg: 'Email not registered!' });
    return;
  }

  const resetCode = Math.floor(1000 + Math.random() * 9000).toString();
  const expires = Date.now() + 15 * 60 * 1000;

  user.resetCode = resetCode;
  user.resetCodeExpires = new Date(expires);
  await user.save();

  try {
    await transporter.sendMail({
      from: "'abf'",
      to: email,
      subject: `Reset password for ${email}`,
      html: `<p>Your password reset code is: <strong>${resetCode}</strong></p>
            <p>This code is valid for 15 minutes.</p>`
    })
  
    res.status(200).json({ msg: 'Email sent successfully!'});  
  } catch (error) {
    res.status(500).json({ msg: error });
  }
}

export const verifyCode: RequestHandler = async (req: Request, res: Response) => {
  const { resetcode, email } = req.body;

  const user = await User.findOne({
    where: { email: email }
  });

  if (user?.resetCode !== resetcode) {
    res.status(400).json({ msg: 'Wrong reset code!' });
    return;
  }

  if (!user?.resetCodeExpires || user.resetCodeExpires.getTime() < Date.now()) {
    res.status(400).json({ msg: 'Reset code expired!' });
    return;
  }

  res.status(200).json({ msg: 'Code verified successfully!' });
}

export const resetPassword: RequestHandler = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  const user = await User.findOne({
    where: { email: email }
  });

  if (!user) {
    res.status(404).json({ msg: 'Email not registered!' });
    return;
  };

  user.password = bcrypt.hashSync(password, 10);
  user.resetCode = null;
  user.resetCodeExpires = null;
  await user.save();

  res.status(204).json({ msg: 'Password reset successfully!' });
}