import pyowm

token = '88983f82566dea8294a9d3e3fb479918'
language = 'ru'
owm = pyowm.OWM(API_key = token, language = language)

def city_temp():
    city = input('Введите название города: ')
    try:
        observation = owm.weather_at_place(city)
    except pyowm.exceptions.not_found_error.NotFoundError:
        print('Такой город не найден, попробуйте еще.')
        city_temp()

    weather = observation.get_weather()
    temp = weather.get_temperature(unit='celsius')['temp']
    status = weather.get_detailed_status()
    print('Текущая температура в городе ' + city + ' ' + str(temp) + ' по цельсию, ' + status + '.')
    city_temp()

city_temp()
