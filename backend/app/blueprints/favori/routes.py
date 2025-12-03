from flask import Blueprint, request, session
from app.blueprints.favori.controller import add_favori_controller,delete_favori_controller,get_favori_controller

favori_route = Blueprint("favori_route",__name__)


@favori_route.route('/add',methods=['POST'])
def add_favori():
    data = request.get_json()
    print(f"[FAVORI ADD] data: {data}")
    
    if not data or 'kullanici_id' not in data:
        return "Lütfen kullanici_id giriniz", 400

    response = add_favori_controller(data)
    return response


@favori_route.route('/delete', methods=['DELETE'])
def delete_favori():
    data = request.get_json()
    print(f"[FAVORI DELETE] data: {data}")
    
    if not data or 'kullanici_id' not in data:
        return "Lütfen kullanici_id giriniz", 400

    response = delete_favori_controller(data)
    return response


@favori_route.route('/get', methods=["GET"])
def get_favori():
    data = request.get_json(silent=True) or request.args.to_dict()
    print(f"[FAVORI GET] data: {data}")
    
    if not data or 'kullanici_id' not in data:
        return "Lütfen kullanici_id giriniz", 400

    response = get_favori_controller(data)
    return response
