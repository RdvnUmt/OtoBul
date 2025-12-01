from sys import prefix
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


    @app.errorhandler(404)
    def handle_exception(e):
        return f"Error 404 Not Found!",404
    
    @app.errorhandler(400)
    def handle_exception(e):
        return f"Error 400 Bad Request!",400
    
    @app.errorhandler(401)
    def handle_exception(e):
        return f"Error 401 Not Authorized!",401
    
    @app.errorhandler(403)
    def handle_exception(e):
        return f"Error 403 Forbidden!",403

    @app.errorhandler(500)
    def handle_exception(e):
        return f"Error 500 Internal server error!",500
    
    @app.errorhandler(502)
    def handle_exception(e):
        return f"Error 502 Bad gateway!",502
    
    @app.errorhandler(503)
    def handle_exception(e):
        return f"Error 503 Service Unavailable!",503




    from app.blueprints.core.core import core
    from app.blueprints.favori.routes import favori_route
    from app.blueprints.user.routes import user_route
    from app.blueprints.adress.routes import adress_route
    from app.blueprints.otomobil.routes import otomobil_route
    from app.blueprints.motosiklet.routes import motosiklet_route
    from app.blueprints.karavan.routes import karavan_route
    from app.blueprints.tir.routes import tir_route
    from app.blueprints.devre_mulk.routes import devre_mulk_route
    from app.blueprints.turistik.routes import turistik_tesis_route
    from app.blueprints.konut.routes import konut_ilan_route
    from app.blueprints.arsa.routes import arsa_route

    app.register_blueprint(core,url_prefix='/core')
    app.register_blueprint(user_route,url_prefix='/user')
    app.register_blueprint(favori_route, url_prefix = '/favori')
    app.register_blueprint(adress_route, url_prefix = '/adres')
    app.register_blueprint(otomobil_route, url_prefix = '/otomobil')
    app.register_blueprint(motosiklet_route, url_prefix = '/motosiklet')
    app.register_blueprint(karavan_route, url_prefix = '/karavan')
    app.register_blueprint(tir_route, url_prefix = '/tir')
    app.register_blueprint(devre_mulk_route, url_prefix = '/devre')
    app.register_blueprint(turistik_tesis_route, url_prefix = '/turistik')
    app.register_blueprint(konut_ilan_route, url_prefix = '/konut')
    app.register_blueprint(arsa_route, url_prefix = '/arsa')

    toolbar.init_app(app)

    return app




