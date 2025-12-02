import sqlalchemy

DATABASE_URL = "mysql://root:123456@localhost:3306/bil372proje"
engine = sqlalchemy.create_engine(
    DATABASE_URL,
)

def dynamic_insert_parser(data):
    
    resultstr = "("
    for item in(data.keys()):
        resultstr =  resultstr  + f" {item},"
    resultstr = resultstr[:len(resultstr)-1]
    resultstr = resultstr + ") VALUES ("
    for item in(data.keys()):
        resultstr =  resultstr  + f" :{item},"
    resultstr = resultstr[:len(resultstr)-1]
    resultstr = resultstr + ");"

    return resultstr, data

def get_method_parser(data):
    filter_str = ""

    if data.get('where'):
        filter_str = "WHERE "
        for item in(data["where"].keys()):
            data[f"{item}"] = data['where'][f"{item}"]
            filter_str =  filter_str  + f"{item} = :{item},"
        filter_str = filter_str[:len(filter_str)-1]

    if data.get('orderby'):  
        filter_str = filter_str +  " ORDERBY "
        for item in(data["orderby"].keys()):
            data[f"{item}"] = data['orderby'][f"{item}"]
            filter_str =  filter_str  + f"{item} = :{item},"
        filter_str = filter_str[:len(filter_str)-1]  

    if data.get('limit'):
        filter_str = filter_str + f" LIMIT {data['limit']}; "
    else:
        filter_str = filter_str + " LIMIT 25;"  

    return filter_str,data

