import sqlalchemy

DATABASE_URL = "mysql://root:123456@localhost/bil372proje"
engine = sqlalchemy.create_engine(
    DATABASE_URL,
)
