from urllib import response
from flask import Blueprint, request
from app.blueprints.konut.controller import add_konut_ilan_controller, delete_konut_ilan_controller, update_konut_ilan_controller, get_konut_ilan_controller


konut_ilan_route = Blueprint("konut_ilan_route",__name__)



@konut_ilan_route.route("/add", methods=['POST'])
def add_konut_ilan():
    data = request.get_json()
    response = add_konut_ilan_controller(data)

    return response

@konut_ilan_route.route("/delete", methods=['DELETE'])
def delete_konut_ilan():
    data= request.get_json()
    response = delete_konut_ilan_controller(data)

    return response

@konut_ilan_route.route("/update", methods=['PUT'])
def update_konut_ilan():
    data= request.get_json()
    response = update_konut_ilan_controller(data)

    return response

@konut_ilan_route.route("/get", methods=['GET'])
def get_konut_ilan():
    data = request.get_json(silent=True) or {}
    response = get_konut_ilan_controller(data)

    return response
