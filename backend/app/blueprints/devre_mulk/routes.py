from urllib import response
from flask import Blueprint, request
from app.blueprints.devre_mulk.controller import add_devre_mulk_controller, delete_devre_mulk_controller, update_devre_mulk_controller, get_devre_mulk_controller


devre_mulk_route = Blueprint("devre_mulk_route",__name__)



@devre_mulk_route.route("/add", methods=['POST'])
def add_devre_mulk():
    data = request.get_json()
    response = add_devre_mulk_controller(data)

    return response

@devre_mulk_route.route("/delete", methods=['DELETE'])
def delete_devre_mulk():
    data= request.get_json()
    response = delete_devre_mulk_controller(data)

    return response

@devre_mulk_route.route("/update", methods=['PUT'])
def update_devre_mulk():
    data= request.get_json()
    response = update_devre_mulk_controller(data)

    return response

@devre_mulk_route.route("/get", methods=['GET'])
def get_devre_mulk():
    data = request.get_json()
    response = get_devre_mulk_controller(data)

    return response
