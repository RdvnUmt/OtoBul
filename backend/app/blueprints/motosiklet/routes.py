from urllib import response
from flask import Blueprint, request
from app.blueprints.motosiklet.controller import add_motosiklet_controller, delete_motosiklet_controller, update_motosiklet_controller, get_motosiklet_controller


motosiklet_route = Blueprint("motosiklet_route",__name__)



@motosiklet_route.route("/add", methods=['POST'])
def add_motosiklet():
    data = request.get_json()
    response = add_motosiklet_controller(data)

    return response

@motosiklet_route.route("/delete", methods=['DELETE'])
def delete_motosiklet():
    data= request.get_json()
    response = delete_motosiklet_controller(data)

    return response

@motosiklet_route.route("/update", methods=['PUT'])
def update_motosiklet():
    data= request.get_json()
    response = update_motosiklet_controller(data)

    return response

@motosiklet_route.route("/get", methods=['GET'])
def get_motosiklet():
    data = request.get_json(silent=True) or {}
    response = get_motosiklet_controller(data)

    return response
