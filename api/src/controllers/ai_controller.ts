import { Request, RequestHandler, Response } from 'express';
import ollama from 'ollama';
import { GoogleGenerativeAI } from '@google/generative-ai';
import OpenAI from 'openai';
import dotenv from 'dotenv';

dotenv.config();

const gemini_ai = new GoogleGenerativeAI(process.env.GEMINI_API_KEY as string);

const open_ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

const prompt = `
  Đây là câu hỏi gửi từ ứng dụng chat với AI, tao muốn trả về json gồm 3 field title, subject
  và content: đầu tiên là field đặt tên cho đoạn chat dựa trên nội dung câu hỏi, 
  field thứ 2 là môn học dựa trên nội dung câu hỏi, field thứ 3 là nội dung đoạn chat.
  Trả lời chính xác (có thể tham khảo từ nguồn tin chính thống như wikipedia, các trang web 
  tin cậy khác), hỏi gì trả lời đấy, trả lời bằng tiếng Việt
`


export const ollamaModel: RequestHandler = async (req: Request, res: Response) => {  
  const { text, model } = req.body;

  if (!text || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  const response = await ollama.chat({
    model: model,
    messages: [{ role: 'user', content: text + prompt }]
  });

  res.status(200).send({
    response: response,
    list: ollama.list
  });
};


export const geminiAI: RequestHandler = async (req: Request, res: Response) => {
  const { text, model } = req.body;

  if (!text || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  const gemini_model = gemini_ai.getGenerativeModel({ model: model });

  await gemini_model.generateContent([text + prompt]).then((response) => {
    res.status(200).send({ response: response });

  }).catch((e) => {
    res.status(400).send({ message: e.message }); 
  });
}

export const openAI: RequestHandler = async (req: Request, res: Response) => {
  const { text, model } = req.body;

  if (!text || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  await open_ai.chat.completions.create({
    model: model,
    messages: [
      { role: 'user', content: text + prompt },
    ],
  }).then((response) => {
    res.status(200).send({ response: response });
  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}
