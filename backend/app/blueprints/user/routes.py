from urllib import response
from app.models.user import User
from flask import Blueprint, request
from app.blueprints.user.controller import add_user_controller,delete_user_controller, update_user_controller,get_user_controller


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
    response = delete_user_controller(data)

    return response

@user_route.route('/update', methods=['PUT'])
def update_user():
    data = request.get_json()
    response = update_user_controller(data)

    return response    


@user_route.route('/get', methods=['GET'])
def get_user():
    data = request.get_json()
    response = get_user_controller(data)
    
    return response
