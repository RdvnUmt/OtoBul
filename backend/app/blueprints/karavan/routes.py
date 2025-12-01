from urllib import response
from flask import Blueprint, request
from app.blueprints.karavan.controller import add_karavan_controller, delete_karavan_controller, update_karavan_controller, get_karavan_controller


karavan_route = Blueprint("karavan_route",__name__)



@karavan_route.route("/add", methods=['POST'])
def add_karavan():
    data = request.get_json()
    response = add_karavan_controller(data)

    return response

@karavan_route.route("/delete", methods=['DELETE'])
def delete_karavan():
    data= request.get_json()
    response = delete_karavan_controller(data)

    return response

@karavan_route.route("/update", methods=['PUT'])
def update_karavan():
    data= request.get_json()
    response = update_karavan_controller(data)

    return response

@karavan_route.route("/get", methods=['GET'])
def get_karavan():
    data = request.get_json(silent=True) or {}
    response = get_karavan_controller(data)

    return response
