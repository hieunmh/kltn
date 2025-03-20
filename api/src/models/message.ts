import { Table, Column, Model, DataType, PrimaryKey, AllowNull, ForeignKey, BelongsTo } from 'sequelize-typescript';
import { MessageType } from '../types/types';
import Chat from './chat';


@Table({
  tableName: 'Messages',
  timestamps: true,
})

class Message extends Model<MessageType> {
  @PrimaryKey
  @AllowNull(false)
  @Column({ type: DataType.UUID })
  id!: string

  @ForeignKey(() => Chat)
  @AllowNull(true)
  @Column({ type: DataType.UUID })
  chat_id!: string;

  @AllowNull(false)
  @Column({ type: DataType.TEXT })
  role!: string;

  @AllowNull(false)
  @Column({ type: DataType.TEXT })
  message!: string;

  @BelongsTo(() => Chat, { as: 'chat' })
  chat!: Chat
}

export default Message;