import sqlalchemy

DATABASE_URL = "mysql://root:123456@localhost/bil372proje"
engine = sqlalchemy.create_engine(
    DATABASE_URL,
)

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

