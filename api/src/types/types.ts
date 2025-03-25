export type UserType = {
  id: string;
  name: string;
  image_url?: string;
  email: string;
  password: string;
  resetCode: string | null;
  resetCodeExpires: Date | null;
  createdAt?: string;
  updatedAt?: string;
}

export type PostType = {
  id: string;
  user_id: string;
  subject: string;
  title: string;
  content: string;
  image_url?: string;

  createdAt?: string;
  updatedAt?: string;
}

export type ChatType = {
  id: string;
  user_id: string;
  name?: string;

  createdAt?: string;
  updatedAt?: string;
}

export type MessageType = {
  id: string;
  chat_id: string;
  role: string;
  message: string;

  createdAt?: string;
  updatedAt?: string;
}

export type CommentType = {
  id: string;
  post_id: string;
  user_id: string;
  content: string;
  image_url?: string;

  createdAt?: string;
  updatedAt?: string;
}