import { Request, RequestHandler, Response } from 'express';
import ollama from 'ollama';
import { GoogleGenerativeAI } from '@google/generative-ai';
import OpenAI from 'openai';
import dotenv from 'dotenv';

dotenv.config();

const gemini_ai = new GoogleGenerativeAI(process.env.GEMINI_API_KEY as string);

const open_ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

const prompt = process.env.CHAT_AI_PROMPT ?? `
 
`;

const topic_prompt = `
  Đây là chủ đề mà người dùng đưa ra, hãy tạo ra một lý thuyết (tóm tắt ngắn gọn) cho chủ đề này, có thể chia thành nhiều đoạn văn,
  trả về dưới dạng json với 2 cặp key, value là topic và theory dưới dạng string, trong đó topic là chủ đề mà người dùng đưa ra,
  còn theory là lý thuyết mà bạn tạo ra cho chủ đề này, lý thuyết có thể chia thành nhiều đoạn văn
`

const review_prompt = `
  Đây là lý thuyết về chủ đề được gửi từ người dùng. Từ nội dung lý thuyết này và chủ đề, hãy tạo ra khoảng 
  4 đến 5 câu hỏi, trả về dưới dạng mảng các string (có thể decode trực tiếp bằng json.decode trong flutter),
`

const voice_prompt = `
  Đây là đoạn text đã được encode bằng json.encode trong flutter. Khi decode đoạn text này, 
  tạo ra được 1 mảng json, trong đó mỗi json có 2 field là question và answer, dựa vào 
  answer ứng với question đấy, hãy đánh giá đúng sai, đúng trả về 1, sai trả về 0, sau đó trả về mảng các đánh giá đấy
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
    response: response
  });
};


export const geminiAI: RequestHandler = async (req: Request, res: Response) => {
  const { text, model, history } = req.body;

  if (!text || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  const fullPrompt = history ? `${history}\nuser: ${text}` : `user: ${text}`;

  const gemini_model = gemini_ai.getGenerativeModel({ model: model });


  await gemini_model.generateContent([fullPrompt + prompt]).then((response) => {
    res.status(200).send({ 
      res: response.response.candidates?.[0]?.content.parts?.[0]?.text,
      response: JSON.parse(response.response.candidates?.[0]?.content.parts?.[0]?.text?.replace(/```json|```/g, "").trim() as string)
    });
    
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
      { role: 'user', content: text },
      { role: 'system', content: prompt}
    ],
  }).then((response) => {
    res.status(200).send({ response: response });
  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}

export const topic_geminiAI: RequestHandler = async (req: Request, res: Response) => {
  const { topic, model } = req.body;

  if (!topic || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  const gemini_model = gemini_ai.getGenerativeModel({ model: model });

  await gemini_model.generateContent([topic + topic_prompt]).then((response) => {
    res.status(200).send({ 
      response: JSON.parse(response.response.candidates?.[0]?.content.parts?.[0]?.text?.replace(/```json|```/g, "").trim() as string)
    });
  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}

export const review_geminiAI: RequestHandler = async (req: Request, res: Response) => {
  const { theory, model } = req.body;
  if (!theory || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }
  const gemini_model = gemini_ai.getGenerativeModel({ model: model });
  await gemini_model.generateContent([theory + review_prompt]).then((response) => {
    res.status(200).send({ 
      response: JSON.parse(response.response.candidates?.[0]?.content.parts?.[0]?.text?.replace(/```json|```/g, "").trim() as string)
    });
  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}

// export const voice_geminiAI: RequestHandler = async (req: Request, res: Response) => {
//   const { text, model } = req.body;

//   if (!text || !model) {
//     res.status(400).send({ message: 'Please fill model name & prompt' });
//     return;
//   }

//   const gemini_model = gemini_ai.getGenerativeModel({ model: model });

//   await gemini_model.generateContent([text]).then((response) => {
//     res.status(200).send({ response: response });
//   }).catch((e) => {
//     res.status(400).send({ message: e.message })
//   });
// }