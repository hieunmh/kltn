/// <reference path="./types/session.d.ts" />

import express from 'express';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import morgan from 'morgan';
import session from 'express-session';

import indexRouter from './routes/index_route';
import connection from './config/connection';
import sessionStore from './config/session';

dotenv.config();

connection.sync().then(() => {
  console.log('Database connected');
});

const PORT = process.env.PORT || 5000

const app = express();

app.use(express.json());

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

app.use(cookieParser());

app.use(morgan('combined'));

app.use(session({
  name: process.env.SESSION_NAME,
  resave: false,
  saveUninitialized: false,
  secret: 'secret',
  store: sessionStore,
  proxy: true,
  cookie: {
    sameSite: 'none',
    secure: false,  
    httpOnly: false,
    maxAge: 30 * 24 * 60 * 60 * 1000,
  }
}))

// CORS

// app.use(cors({
//   credentials: true,
//   origin: process.env.CLIENT_URL
// }))

app.use(indexRouter);

app.set('trust proxy', true);


app.get('/', (req, res) => {
  res.status(200).send('Hello from KLTN app');
});

app.listen(Number(PORT), '0.0.0.0', () => {
  console.log(`Server đang chạy trên http://0.0.0.0:${PORT}`);
  // console.log(`Để truy cập từ thiết bị khác, sử dụng địa chỉ IP của máy tính (192.168.10.142:${PORT})`);
});