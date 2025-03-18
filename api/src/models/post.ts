import { Table, Column, Model, DataType, PrimaryKey, AllowNull, ForeignKey, BelongsTo } from 'sequelize-typescript';
import { PostType } from '../types/types';
import User from './user';

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
}

export default Post;