import { Table, Column, Model, DataType, PrimaryKey, AllowNull, ForeignKey, BelongsTo } from 'sequelize-typescript';
import { PostType } from '../types/types';
import Users from './user';

@Table({
  tableName: 'Posts',
  timestamps: true,
})

class Posts extends Model<PostType> {
  @PrimaryKey
  @AllowNull(false)
  @Column({ type: DataType.UUID })
  id!: string

  @ForeignKey(() => Users)
  @AllowNull(true)
  @Column({ type: DataType.UUID })
  user_id!: string;

  @AllowNull(false)
  @Column({ type: DataType.STRING })
  subject!: string;

  @AllowNull(false)
  @Column({ type: DataType.STRING })
  title!: string;

  @AllowNull(false)
  @Column({ type: DataType.STRING })
  content!: string;

  @AllowNull(true)
  @Column({ type: DataType.STRING })
  image_url!: string | null;

  @BelongsTo(() => Users, { as: 'user' })
  user!: Users
}

export default Posts;