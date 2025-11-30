from flask import Flask, Blueprint
from flask_cors import CORS
from app.extensions.tools import toolbar
import sqlalchemy
import pymysql

pymysql.install_as_MySQLdb()
#Engine için Mysql clientını oluşturur.
#Ya da mysqlclient

def create_app():
    app = Flask(__name__)

    app.config['SQLALCHEMY_DATABAE_URI'] = ''
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    
    CORS(app)

    from app.blueprints.core.core import core
    from app.blueprints.user.routes import user_route
    app.register_blueprint(core,url_prefix='/core')
    app.register_blueprint(user_route,url_prefix='/user')

    toolbar.init_app(app)

    return app




