from flask import Blueprint, request
from app.blueprints.favori.controller import add_favori_controller,delete_favori_controller,get_favori_controller

favori_route = Blueprint("favori_route",__name__)


@favori_route.route('/add',methods=['POST'])
def add_favori():
    data = request.get_json()
    response = add_favori_controller(data)

    return response


@favori_route.route('/delete', methods=['DELETE'])
def delete_favori():
    data = request.get_json()
    response = delete_favori_controller(data)

    return response


@favori_route.route('/get', methods=["GET"])
def get_favori():
    data = request.args.to_dict()
    response = get_favori_controller(data)

    return response
