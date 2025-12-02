
#from app.blueprints.konut.controller import get_konut_ilan_controller



#Gets user and data and controls if ids are the same
from flask import session



def id_control_policy(func_name,where_id, data):

    from app.blueprints.konut.controller import get_konut_ilan_controller
    from app.blueprints.karavan.controller import get_karavan_controller 
    from app.blueprints.arsa.controller import get_arsa_controller
    from app.blueprints.devre_mulk.controller import get_devre_mulk_controller
    from app.blueprints.motosiklet.controller import get_motosiklet_controller
    from app.blueprints.otomobil.controller import get_otomobil_controller
    from app.blueprints.tir.controller import get_tir_controller
    from app.blueprints.turistik.controller import get_turistik_tesis_controller

    func_to_call = eval(f"get_{func_name}_controller")
    #get_konut_ilan_controller(data)

    func_arg = {"where": {f"{where_id}": f"{data[f'{where_id}']}"}}

    response= func_to_call(func_arg)
    print("Response returned")

    print(f"{response}")
    print(f"{response[0]}")
    
    print(f"{response[0][0]['kullanici_id']}")
    print(session['user']['kullanici_id'])

    if session['user']['kullanici_id'] == response[0][0]['kullanici_id']:
        return True
    else:
        return False
