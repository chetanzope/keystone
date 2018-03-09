import sqlalchemy as sql


def upgrade(migrate_engine):
    meta = sql.MetaData()
    meta.bind = migrate_engine

    first_name = sql.Column('first_name', sql.String(length=255), nullable=True)
    last_name = sql.Column('last_name', sql.String(length=255), nullable=True)
    user_table = sql.Table('user', meta, autoload=True)
    user_table.create_column(first_name)
    user_table.create_column(last_name)

