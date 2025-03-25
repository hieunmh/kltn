import { Table, Column, Model, DataType, Unique, PrimaryKey, AllowNull, HasMany } from 'sequelize-typescript';
import { UserType } from '../types/types';
import Post from './post';
import Chat from './chat';
import Comment from './comment';

@Table({
  tableName: 'Users',
  timestamps: true,
})

class User extends Model<UserType> {
  @PrimaryKey
  @AllowNull(false)
  @Column({ type: DataType.UUID })
  id!: string

  @AllowNull(true)
  @Column({ type: DataType.STRING })
  name!: string;

  @AllowNull(true)
  @Column({ type: DataType.TEXT })
  image_url!: string;

  @Unique
  @AllowNull(false)
  @Column({ type: DataType.STRING })
  email!: string;

  @AllowNull(false)
  @Column({ type: DataType.STRING })
  password!: string;

  @AllowNull(true)
  @Column({ type: DataType.STRING })
  resetCode!: string | null;

  @AllowNull(true)
  @Column({ type: DataType.DATE })
  resetCodeExpires!: Date | null;

  @HasMany(() => Post, { as: 'posts' })
  posts!: Post[]

  @HasMany(() => Chat, { as: 'chats' })
  chats!: Chat[]

  @HasMany(() => Comment, { as: 'comments' })
  comments!: Comment[]
}

export default User;