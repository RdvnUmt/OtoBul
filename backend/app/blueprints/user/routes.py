from app.models.user import User
from flask import Blueprint, request
from app.blueprints.user.service import add_user_service


user_route = Blueprint("user_route",__name__)


@user_route.route('/add',methods=['POST'])
def add_user():
    data = request.get_json()
    add_user_service()
   
    return "Başarılı",200 




