from urllib import response
from flask import Blueprint, request
from app.blueprints.turistik.controller import add_turistik_tesis_controller, delete_turistik_tesis_controller, update_turistik_tesis_controller, get_turistik_tesis_controller


turistik_tesis_route = Blueprint("turistik_tesis_route",__name__)



@turistik_tesis_route.route("/add", methods=['POST'])
def add_turistik_tesis():
    data = request.get_json()
    response = add_turistik_tesis_controller(data)

    return response

@turistik_tesis_route.route("/delete", methods=['DELETE'])
def delete_turistik_tesis():
    data= request.get_json()
    response = delete_turistik_tesis_controller(data)

    return response

@turistik_tesis_route.route("/update", methods=['PUT'])
def update_turistik_tesis():
    data= request.get_json()
    response = update_turistik_tesis_controller(data)

    return response

@turistik_tesis_route.route("/get", methods=['GET'])
def get_turistik_tesis():
    data = request.args.to_dict()
    response = get_turistik_tesis_controller(data)

    return response
