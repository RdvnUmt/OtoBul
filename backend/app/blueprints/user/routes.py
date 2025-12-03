from urllib import response
from flask import Blueprint, request
from app.blueprints.user.controller import add_user_controller,delete_user_controller, update_user_controller,get_user_controller
from flask import session

user_route = Blueprint("user_route",__name__)


@user_route.route('/add',methods=['POST'])
def add_user():
    data = request.get_json()

    response = add_user_controller(data)

    return response

@user_route.route('/delete',methods=['DELETE'])
def delete_user():
    #kullanıcı_id ver kafi aga
    data  = request.get_json()

    try: 
        if not session['user']['kullanici_id'] == data['kullanici_id']:
            return "Bunu yapmaya yetkiniz yok", 401
    except:
        return "Lütfen kullanici_id giriniz",400

    response = delete_user_controller(data)
    session['user']  = {}

    return response

@user_route.route('/update', methods=['PUT'])
def update_user():
    data = request.get_json()

    try: 
        if not session['user']['kullanici_id'] == data['kullanici_id']:
            return "Bunu yapmaya yetkiniz yok", 401
    except:
        return "Lütfen kullanici_id giriniz",400

    response = update_user_controller(data)

    return response    


@user_route.route('/get', methods=['GET'])
def get_user():
    data = request.args.to_dict()
    response = get_user_controller(data)
    
    return response
