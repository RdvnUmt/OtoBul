from flask import Flask, request, session
from flask_cors import CORS
from app.extensions.tools import toolbar
import pymysql
from flask_bcrypt import Bcrypt
from datetime import timedelta

pymysql.install_as_MySQLdb()


def create_app():
    app = Flask(__name__)

    app.config['SQLALCHEMY_DATABASE_URI'] = ''
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SECRET_KEY'] = 'thisisasecretkey'
    app.permanent_session_lifetime = timedelta(days=14)
    CORS(app)

    bcrypt = Bcrypt(app)
    


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


    from app.blueprints.user.controller import get_user_controller, add_user_controller    

    @app.route('/login',methods=['POST'])
    def login():
        data = request.get_json()
        sifre = data['sifre']

        print(sifre)
        
        user = get_user_controller(data)
        print(user)
        print("User ele geçirildi mi ne oldu!")
        print(user[0])
        if bcrypt.check_password_hash(user[0]['sifre'], sifre):
            print("Login başarılı kaydediliyor")
            print(user[0])
            
            session.permanent = True
            session["user"] = user[0] # Sadece user nesnesini al.

            return str(user[0]['kullanici_id']),200
        else: 
            return "Şifre veya maili yanlış girdiniz", 400

    @app.route('/user', methods=['GET'])
    def user():
        
        if "user" in session:
            return session["user"], 200
        else: 
            return "User bulunamadı", 200

    @app.route('/logout')
    def logout():
        session.pop("user", None)
        return "Logout başarılı",200


    @app.route('/signup',methods=['POST'])
    def signup():
        data = request.get_json()
        sifre = data['sifre']

        hashed_sifre = bcrypt.generate_password_hash(sifre)
        data['sifre'] = hashed_sifre

        response = add_user_controller(data)

        return response



    toolbar.init_app(app)

    return app




