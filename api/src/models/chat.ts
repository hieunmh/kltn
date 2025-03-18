import { Table, Column, Model, DataType, PrimaryKey, AllowNull, ForeignKey, BelongsTo, HasMany } from 'sequelize-typescript';
import { ChatType } from '../types/types';
import User from './user';
import Message from './message';

@Table({
  tableName: 'Chats',
  timestamps: true,
})

class Chat extends Model<ChatType> {
  @PrimaryKey
  @AllowNull(false)
  @Column({ type: DataType.UUID })
  id!: string

  @ForeignKey(() => User)
  @AllowNull(true)
  @Column({ type: DataType.UUID })
  user_id!: string;

  @AllowNull(false)
  @Column({ type: DataType.TEXT })
  name!: string;

  @BelongsTo(() => User, { as: 'user' })
  user!: User

  @HasMany(() => Message, { as: 'messages' })
  messages!: Message[]
}

export default Chat;