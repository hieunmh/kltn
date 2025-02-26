import { Table, Column, Model, DataType, Unique, PrimaryKey, AllowNull } from 'sequelize-typescript';
import { UserType } from '../types/types';

@Table({
  tableName: 'Users',
  timestamps: true,
})

class Users extends Model<UserType> {
  @PrimaryKey
  @AllowNull(false)
  @Column({
    type: DataType.UUID,
  })
  id!: string

  @AllowNull(false)
  @Column({ type: DataType.STRING })
  name!: string;

  @Unique
  @AllowNull(false)
  @Column({ type: DataType.STRING })
  email!: string;

  @AllowNull(false)
  @Column({ type: DataType.STRING })
  password!: string;
}

export default Users;