import { Table, Column, Model, DataType, Unique, PrimaryKey, HasMany, AllowNull } from 'sequelize-typescript';

@Table({
    tableName: 'Users',
    timestamps: true
})

class Users extends Model {
    @PrimaryKey
    @AllowNull(false)
    @Column(DataType.UUID)
    id!: string

    @AllowNull(false)
    @Column(DataType.STRING)
    name!: string

    @AllowNull(false)
    @Column(DataType.STRING)
    email!: string

    @AllowNull(false)
    @Column(DataType.STRING)
    password!: string
}