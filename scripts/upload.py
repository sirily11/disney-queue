from typing import Tuple
from tqdm import tqdm
import pandas as pd
import os
import psycopg2
import numpy as np

endpoint = os.getenv('endpoint')
password = os.getenv('password')
username = os.getenv('username')
database_name = 'dataset'
data_path = '../data/disney_shanghai.csv'


def preprocess_data() -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Returns weather, facility, wait-time
    :return:
    """
    data = pd.read_csv(data_path)
    data.replace({np.nan: None}, inplace=True)
    data['Time'] = data['Time'].apply(lambda x: x.split('.')[0] + '+0800')
    data['Time'] = pd.to_datetime(data['Time'])
    weather_data = data[
        ['Time', 'Weather', 'Weather description', 'Temperature', 'Max temperature', 'Min temperature', 'Pressure',
         'Humidity', 'Wind degree', 'Wind speed', 'Cloud', 'Visibility']].drop_duplicates()

    wait_data = data[['Id', 'Wait time', 'Status', 'Fastpass-available']]
    return weather_data, wait_data


if not os.path.exists(data_path):
    print("Disney is not open")
else:
    print("Start")

    weather_data, wait_data = preprocess_data()
    # print(weather_data.columns)

    conn = psycopg2.connect(user=username,
                            password=password,
                            host=endpoint,
                            port='5432',
                            database=database_name)

    cursor = conn.cursor()

    sql = """insert into weather
            (time, weather_description, max_temperature, min_temperature, pressure, wind_degree, wind_speed, cloud, visibility, weather, temperature, humidity) values
            (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) returning id;"""

    weather_list = weather_data.values.tolist()[0]
    time = weather_list[0]
    weather = weather_list[1]
    weather_description = weather_list[2]
    temperature = weather_list[3]
    max_temperature = weather_list[4]
    min_temp = weather_list[5]
    pressure = weather_list[6]
    humidity = weather_list[7]
    wind_deg = weather_list[8]
    wind_spe = weather_list[9]
    cloud = weather_list[10]
    vis = weather_list[11]

    cursor.execute(sql,
                   [time, weather_description, max_temperature, min_temp, pressure, wind_deg, wind_spe, cloud, vis,
                    weather,
                    temperature, humidity])

    weather_id = cursor.fetchone()[0]
    for d in tqdm(wait_data.values.tolist()):
        sql = "insert into wait_time(facility_id, weather_id, wait_time, status, fastpass) VALUES (%s, %s, %s, %s, %s)"
        facility = d[0]
        wait_time = d[1]
        status = d[2]
        fast = d[3]
        cursor.execute(sql, [facility, weather_id, wait_time, status, fast])

    conn.commit()
    print("finished")
