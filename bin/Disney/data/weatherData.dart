// To parse this JSON data, do
//
//     final weatherData = weatherDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'Info.dart';

class WeatherData with CsvCodable {
  WeatherData({
    @required this.coord,
    @required this.weather,
    @required this.base,
    @required this.main,
    @required this.visibility,
    @required this.wind,
    @required this.clouds,
    @required this.dt,
    @required this.sys,
    @required this.timezone,
    @required this.id,
    @required this.name,
    @required this.cod,
  });

  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  @override
  List<RowResult> get variables => [
        if (weather != null)
          RowResult(value: weather.isNotEmpty ? weather.first : null),
        RowResult(value: main),
        RowResult(value: wind),
        RowResult(value: clouds),
        RowResult(value: visibility, variableName: 'visibility'),
      ];

  WeatherData copyWith({
    Coord coord,
    List<Weather> weather,
    String base,
    Main main,
    int visibility,
    Wind wind,
    Clouds clouds,
    int dt,
    Sys sys,
    int timezone,
    int id,
    String name,
    int cod,
  }) =>
      WeatherData(
        coord: coord ?? this.coord,
        weather: weather ?? this.weather,
        base: base ?? this.base,
        main: main ?? this.main,
        visibility: visibility ?? this.visibility,
        wind: wind ?? this.wind,
        clouds: clouds ?? this.clouds,
        dt: dt ?? this.dt,
        sys: sys ?? this.sys,
        timezone: timezone ?? this.timezone,
        id: id ?? this.id,
        name: name ?? this.name,
        cod: cod ?? this.cod,
      );

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        coord: Coord.fromJson(json['coord']),
        weather:
            List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
        base: json['base'],
        main: Main.fromJson(json['main']),
        visibility: json['visibility'],
        wind: Wind.fromJson(json['wind']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        sys: Sys.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
      );

  @override
  String toString() {
    return '[weatherData: $name - ${weather[0].main}]';
  }

  Map<String, dynamic> toJson() => {
        'coord': coord.toJson(),
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
        'base': base,
        'main': main.toJson(),
        'visibility': visibility,
        'wind': wind.toJson(),
        'clouds': clouds.toJson(),
        'dt': dt,
        'sys': sys.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };
}

class Clouds with CsvCodable {
  Clouds({
    @required this.all,
  });

  final int all;

  @override
  List<RowResult> get variables => [
        RowResult(value: all, variableName: 'cloud'),
      ];

  Clouds copyWith({
    int all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json['all'],
      );

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}

class Coord  {
  Coord({
    @required this.lon,
    @required this.lat,
  });

  final double lon;
  final double lat;

  Coord copyWith({
    double lon,
    double lat,
  }) =>
      Coord(
        lon: lon ?? this.lon,
        lat: lat ?? this.lat,
      );

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon'].toDouble(),
        lat: json['lat'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}

class Main with CsvCodable {
  Main({
    @required this.temp,
    @required this.feelsLike,
    @required this.tempMin,
    @required this.tempMax,
    @required this.pressure,
    @required this.humidity,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  @override
  List<RowResult> get variables => [
        RowResult(value: tempCelsius, variableName: 'temperature'),
        RowResult(value: tempMaxCelsius, variableName: 'max temperature'),
        RowResult(value: tempMaxCelsius, variableName: 'min temperature'),
        RowResult(value: pressure, variableName: 'pressure'),
        RowResult(value: humidity, variableName: 'humidity'),
      ];

  Main copyWith({
    double temp,
    double feelsLike,
    double tempMin,
    double tempMax,
    int pressure,
    int humidity,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
      );

  double get tempCelsius => temp - 273.15;

  double get tempMaxCelsius => tempMax - 273.15;

  double get tempMinCelsius => tempMin - 273.15;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'].toDouble(),
        feelsLike: json['feels_like'].toDouble(),
        tempMin: json['temp_min'].toDouble(),
        tempMax: json['temp_max'].toDouble(),
        pressure: json['pressure'],
        humidity: json['humidity'],
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      };
}

class Sys {
  Sys({
    @required this.type,
    @required this.id,
    @required this.country,
    @required this.sunrise,
    @required this.sunset,
  });

  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys copyWith({
    int type,
    int id,
    String country,
    int sunrise,
    int sunset,
  }) =>
      Sys(
        type: type ?? this.type,
        id: id ?? this.id,
        country: country ?? this.country,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json['type'],
        id: json['id'],
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}

class Weather with CsvCodable{
  Weather({
    @required this.id,
    @required this.main,
    @required this.description,
    @required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  @override
  List<RowResult> get variables => [
        RowResult(value: main, variableName: 'weather'),
        RowResult(value: description, variableName: 'weather description')
      ];

  Weather copyWith({
    int id,
    String main,
    String description,
    String icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}

class Wind with CsvCodable{
  Wind({
    @required this.speed,
    @required this.deg,
  });

  final int speed;
  final int deg;

  @override
  List<RowResult> get variables => [
        RowResult(value: deg, variableName: 'wind degree'),
        RowResult(value: speed, variableName: 'wind speed'),
      ];

  Wind copyWith({
    int speed,
    int deg,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
      );

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json['speed'],
        deg: json['deg'],
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };
}
