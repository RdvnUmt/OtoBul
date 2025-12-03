from urllib import response
from flask import Blueprint, request
from app.blueprints.arsa.controller import add_arsa_controller, delete_arsa_controller, update_arsa_controller, get_arsa_controller


arsa_route = Blueprint("arsa_route",__name__)



@arsa_route.route("/add", methods=['POST'])
def add_arsa():
    data = request.get_json()
    response = add_arsa_controller(data)

    return response

@arsa_route.route("/delete", methods=['DELETE'])
def delete_arsa():
    data= request.get_json()
    response = delete_arsa_controller(data)

    return response

@arsa_route.route("/update", methods=['PUT'])
def update_arsa():
    data= request.get_json()
    response = update_arsa_controller(data)

    return response

@arsa_route.route("/get", methods=['GET','POST'])
def get_arsa():
    if request.method == 'POST':
        data = request.get_json() or {}
    else:
        data = request.args.to_dict()

    response = get_arsa_controller(data)

    return response
