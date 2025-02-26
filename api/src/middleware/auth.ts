import { Request, Response, NextFunction } from 'express';

export const isAuth = (req: Request, res: Response, next: NextFunction) => {
  if (!req.session.userId) {
    res.status(200).json({
      msg: 'You need to log in first!',
      user: null
    });
    return;
  }
  next();
}

export const isLoggedIn = (req: Request, res: Response, next: NextFunction) => {
  if (req.session.userId) {
    res.status(200).json({
      msg: 'Already login!',
    });
    return;
  }
  next();
}