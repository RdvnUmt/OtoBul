import sqlalchemy

DATABASE_URL = "mysql://root:123456@localhost:3306/bil372proje"
engine = sqlalchemy.create_engine(
    DATABASE_URL,
)
