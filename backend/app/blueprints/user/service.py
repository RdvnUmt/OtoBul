from app.models.user import User
from sqlalchemy.sql import text
from app.utils.utils import engine 


def add_user_service():
    
    with engine.connect() as con:

        data = ( { "id": 1, "title": "The Hobbit", "primary_author": "Tolkien" },
             { "id": 2, "title": "The Silmarillion", "primary_author": "Tolkien" },
        )

        statement = text("""INSERT INTO book(id, title, primary_author) VALUES(:id, :title, :primary_author)""")

        for line in data:
            con.execute(statement, line)

        con.commit()