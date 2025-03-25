import { Table, Column, Model, DataType, PrimaryKey, AllowNull, ForeignKey, BelongsTo } from 'sequelize-typescript';
import { CommentType } from '../types/types';
import User from './user';
import Post from './post';

@Table({
  tableName: 'Comments',
  timestamps: true,
})

class Comment extends Model<CommentType> {
  @PrimaryKey
  @AllowNull(false)
  @Column({ type: DataType.UUID })
  id!: string

  @ForeignKey(() => User)
  @AllowNull(true)
  @Column({ type: DataType.UUID })
  user_id!: string;

  @ForeignKey(() => Post)
  @AllowNull(false)
  @Column({ type: DataType.UUID })
  post_id!: string;

  @AllowNull(false)
  @Column({ type: DataType.TEXT })
  content!: string;

  @AllowNull(true)
  @Column({ type: DataType.TEXT })
  image_url!: string | null;

  @BelongsTo(() => User, { as: 'user' })
  user!: User

  @BelongsTo(() => Post, { as: 'post' })
  post!: Post
}

export default Comment;