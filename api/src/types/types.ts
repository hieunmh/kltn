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