export type UserType = {
  id: string;
  name: string;
  email: string;
  password: string;
  resetCode: string | null;
  resetCodeExpires: Date | null;
}