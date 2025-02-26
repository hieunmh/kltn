/// <reference path="./types/session.d.ts" />

import express from 'express';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import morgan from 'morgan';
import session from 'express-session';

import indexRouter from './routes/index_router';
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
    sameSite: process.env.SAME_SITE as 'none' | 'lax' | 'strict',
    secure: process.env.COOKIE_SECURE === 'true',
    httpOnly: process.env.COOKIE_HTTP_ONLY === 'true',
    // maxAge: 30 * 24 * 60 * 60 * 1000,
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

app.listen(PORT, () => {
  console.log(`server running on port ${PORT}`);
});