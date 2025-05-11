import { Request, RequestHandler, Response } from 'express';
import ollama from 'ollama';
import { GoogleGenerativeAI } from '@google/generative-ai';
import OpenAI from 'openai';
import dotenv from 'dotenv';

dotenv.config();

const gemini_ai = new GoogleGenerativeAI(process.env.GEMINI_API_KEY as string);

const open_ai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

const prompt = process.env.CHAT_AI_PROMPT ?? ``;

const topic_prompt = `
  Đây là chủ đề mà người dùng đưa ra, hãy tạo ra một lý thuyết (tóm tắt ngắn gọn) cho chủ đề này, có thể chia thành nhiều đoạn văn,
  trả về dưới dạng json với 2 cặp key, value là topic và theory dưới dạng string, trong đó topic là chủ đề mà người dùng đưa ra,
  còn theory là lý thuyết mà bạn tạo ra cho chủ đề này, lý thuyết có thể chia thành nhiều đoạn văn, ví dụ:
  {
    "topic": "topic",
    "theory": "theory"
  }
`

const review_prompt = `
  Đây là lý thuyết về chủ đề được gửi từ người dùng. Từ nội dung lý thuyết này và chủ đề, hãy tạo ra khoảng 
  4 đến 5 câu hỏi, nội dung câu hỏi có thể trả lời bằng giọng nói, 
  trả về dưới dạng mảng các string (có thể decode trực tiếp bằng json.decode trong flutter), ví dụ:
  [
    "Câu hỏi 1",
    "Câu hỏi 2",
    "Câu hỏi 3",
    "Câu hỏi 4",
    "Câu hỏi 5"
  ]
`

const voice_prompt = `
  Đây là đoạn text đã được encode bằng json.encode trong flutter. Khi decode đoạn text này, 
  tạo ra được 1 mảng json, trong đó mỗi json có 2 field là question và answer, dựa vào 
  answer ứng với question đấy, hãy đánh giá đúng sai, đúng trả về 1, sai trả về 0, 
  sau đó trả về các đánh giá đấy dưới dạng mảng json, mỗi json có 2 field là evaluate và explain, 
  evaluate là 1 nếu đúng, 0 nếu sai, explain là câu trả lời của bạn dựa trên answer và question, ví dụ: 
  khi question là "điều kiện của biến a trong phương trình ax+b=0 là gì?", answer là "a khác 0", 
  explain sẽ là "Điều kiện của biến a trong phương trình ax+b=0 là a khác 0",
  và do answer dùng thư viện speed_to_text nên có thể có lỗi, hãy sửa lỗi đó
`

const suggest_prompt = `
  Đây là trình độ học vấn (level) của người dùng và tên môn học (subject).
  
  Hãy kiểm tra tên môn học trước. Nếu tên môn học không phải là tên của một môn họctrong chương 
  trình giáo dục (như Toán, Văn, Anh, Lý, Hóa, Sinh, Sử, Địa, Công nghệ, Tin học, v.v.), 
  thì đây là môn học không hợp lệ.
  
  Nếu môn học KHÔNG hợp lệ, trả về JSON có dạng: 
  {
    "suggest_theme": "",
    "error": "Tên môn học không hợp lệ"
  }
  
  Nếu môn học hợp lệ, hãy tạo ra một chủ đề phù hợp với trình độ mà người dùng có thể học tập, và trả về JSON có dạng:
  {
    "suggest_theme": "Chủ đề phù hợp với môn học và trình độ",
    "error": ""
  }
  
  QUAN TRỌNG: Đối với những chuỗi ngẫu nhiên như "dsafdfsdasfsa", "asdasd", hoặc các từ không phải tên môn học thực sự, PHẢI xác định là môn học không hợp lệ.
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
  const { text, model, history } = req.body;

  if (!text || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  const fullPrompt = history ? `${history}\nuser: ${text}` : `user: ${text}`;


  await open_ai.chat.completions.create({
    model: model,
    messages: [
      { role: 'user', content: text },
      { role: 'system', content: fullPrompt + prompt}
    ],
  }).then((response) => {
    res.status(200).send({ 
      res: response.choices[0].message.content,
      response: JSON.parse(response.choices[0].message.content!.replace(/```json|```/g, "").trim() as string)
    });

  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}

export const topic_AI: RequestHandler = async (req: Request, res: Response) => {
  const { topic, model, ainame } = req.body;

  if (!topic || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt & ainame' });
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

export const review_AI: RequestHandler = async (req: Request, res: Response) => {
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

export const voice_AI: RequestHandler = async (req: Request, res: Response) => {
  const { data, model } = req.body;

  if (!data || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt' });
    return;
  }

  const gemini_model = gemini_ai.getGenerativeModel({ model: model });

  await gemini_model.generateContent([data + voice_prompt]).then((response) => {
    res.status(200).send({ 
      response: response.response.candidates?.[0]?.content.parts?.[0]?.text?.replace(/```(json)?\n?|\n?```/g, "").trim() as string,
      raw: response.response.candidates?.[0]?.content.parts?.[0]?.text
    });
  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}

export const suggest_AI: RequestHandler = async (req: Request, res: Response) => {
  const { level, subject, model } = req.body;

  if (!level || !subject || !model) {
    res.status(400).send({ message: 'Please fill model name & prompt & subject & level' });
    return;
  }
  
  const gemini_model = gemini_ai.getGenerativeModel({ model: model });

  await gemini_model.generateContent([`Level: ${level}, Subject: ${subject}` + suggest_prompt]).then((response) => {
    const rawResponse = response.response.candidates?.[0]?.content.parts?.[0]?.text || '';
    
    try {
      const parsedResponse = JSON.parse(rawResponse.replace(/```json|```/g, "").trim());
      res.status(200).send({ 
        response: parsedResponse,
        raw: rawResponse,
      });
    } catch (e) {
      res.status(200).send({ 
        response: { 
          suggest_theme: "", 
          error: "Không thể xử lý phản hồi từ AI" 
        },
        raw: rawResponse,
      });
    }
  }).catch((e) => {
    res.status(400).send({ message: e.message })
  });
}
