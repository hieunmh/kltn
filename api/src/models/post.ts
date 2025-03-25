import { Table, Column, Model, DataType, PrimaryKey, AllowNull, ForeignKey, BelongsTo, HasMany } from 'sequelize-typescript';
import { PostType } from '../types/types';
import User from './user';
import Comment from './comment';

@Table({
  tableName: 'Posts',
  timestamps: true,
})

class Post extends Model<PostType> {
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
  subject!: string;

  @AllowNull(false)
  @Column({ type: DataType.TEXT })
  title!: string;

  @AllowNull(false)
  @Column({ type: DataType.TEXT })
  content!: string;

  @AllowNull(true)
  @Column({ type: DataType.TEXT })
  image_url!: string | null;

  @BelongsTo(() => User, { as: 'user' })
  user!: User

  @HasMany(() => Comment, { as: 'comments', onDelete: 'CASCADE' })
  comments!: Comment[]
}

export default Post;