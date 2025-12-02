from urllib import response
from flask import Blueprint, request
from app.blueprints.otomobil.controller import add_otomobil_controller, delete_otomobil_controller, update_otomobil_controller, get_otomobil_controller


otomobil_route = Blueprint("otomobil_route",__name__)



@otomobil_route.route("/add", methods=['POST'])
def add_otomobil():
    data = request.get_json()
    response = add_otomobil_controller(data)

    return response

@otomobil_route.route("/delete", methods=['DELETE'])
def delete_otomobil():
    data= request.get_json()
    response = delete_otomobil_controller(data)

    return response

@otomobil_route.route("/update", methods=['PUT'])
def update_otomobil():
    data= request.get_json()
    response = update_otomobil_controller(data)

    return response

@otomobil_route.route("/get", methods=['GET'])
def get_otomobil():
    data = request.args.to_dict()
    response = get_otomobil_controller(data)

    return response
