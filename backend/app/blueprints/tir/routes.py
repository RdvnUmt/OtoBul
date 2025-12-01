from urllib import response
from flask import Blueprint, request
from app.blueprints.tir.controller import add_tir_controller, delete_tir_controller, update_tir_controller, get_tir_controller


tir_route = Blueprint("tir_route",__name__)



@tir_route.route("/add", methods=['POST'])
def add_tir():
    data = request.get_json()
    response = add_tir_controller(data)

    return response

@tir_route.route("/delete", methods=['DELETE'])
def delete_tir():
    data= request.get_json()
    response = delete_tir_controller(data)

    return response

@tir_route.route("/update", methods=['PUT'])
def update_tir():
    data= request.get_json()
    response = update_tir_controller(data)

    return response

@tir_route.route("/get", methods=['GET'])
def get_tir():
    data = request.get_json(silent=True) or {}
    response = get_tir_controller(data)

    return response
