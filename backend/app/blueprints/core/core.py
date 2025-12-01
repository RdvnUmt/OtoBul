from flask import Blueprint 


core = Blueprint('core',__name__)


@core.route('/')
def index():
    return "That a core index point"