import { Request, RequestHandler, response, Response } from 'express';
import Users from '../models/user';
import { v4 as uuidv4 } from 'uuid';
import bcrypt from 'bcrypt';
import { UserType } from '../types/types';

export const signup: RequestHandler = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  if (!email || ! password) {
    res.status(400).json({ message: 'Please fill all fields' });
    return;
  }

  await Users.create({
    id: uuidv4(),
    name: '',
    email: email,
    password: bcrypt.hashSync(password, 10)
  }).then((user: UserType) => {
    req.session.userId = user.id;

    res.status(201).json({
      user: {
        id: user.id,
        name: user.name,
        email: user.email
      },
      id: req.session.cookie,
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

  const user = await Users.findOne({
    attributes: ['id', 'name', 'email', 'password'],
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

  res.status(200).json({
    user: {
      id: user.id,
      name: user.name,
      email: user.email
    },
    msg: 'Login successfully!'
  });
}

export const signout: RequestHandler = async (req: Request, res: Response) => {
  if (!req.session.userId) {
    res.status(200).json({ msg: 'Logout error!' });
    return;
  }

  req.session.destroy((err) => {
    if (err) {
      res.status(500).json({ msg: 'Internal error!' });
      return;
    }
  })

  res.clearCookie('sid');

  res.status(200).json({ msg: 'Logout successfully!' });
}