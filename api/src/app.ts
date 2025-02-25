import express from 'express';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import morgan from 'morgan';
// import cors from 'cors';

dotenv.config();

const PORT = process.env.PORT || 5000

const app = express();

app.use(express.json());

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

app.use(cookieParser());

app.use(morgan('combined'));

// CORS

// app.use(cors({
//   credentials: true,
//   origin: process.env.CLIENT_URL
// }))

app.set('trust proxy', true);


app.get('/', (req, res) => {
  res.status(200).send('Hello from KLTN app');
});

app.listen(PORT, () => {
  console.log(`server running on port ${PORT}`);
});