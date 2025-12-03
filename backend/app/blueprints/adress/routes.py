from app.blueprints.adress.controller import add_address_controller, delete_address_controller, update_address_controller,get_address_controller
from flask import Blueprint, request


adress_route = Blueprint("adress_route", __name__)

@adress_route.route('/add',methods=["POST"])
def add_adress():
    
    data = request.get_json()
    response = add_address_controller(data)

    return response


@adress_route.route('/delete',methods=["DELETE"])
def delete_adress():
    
    data = request.get_json()
    response = delete_address_controller(data)

    return response

@adress_route.route('/update',methods=["PUT"])
def update_adress():
    
    data = request.get_json()
    response = update_address_controller(data)

    return response


@adress_route.route('/get', methods=["GET"])
def get_adress():
    data = request.args.to_dict()
    response = get_address_controller(data)

    return response