import 'package:meta/meta.dart';
import 'package:timezone/standalone.dart' as tz;
import '../utils/utils.dart';
import 'FacilitiesData.dart';
import 'weatherData.dart';

class RowResult {
  dynamic value;
  String variableName;

  RowResult({@required this.value, this.variableName});
}

abstract class CsvCodable {
  List<RowResult> get variables;

  List<RowResult> toCsvRow() {
    var row = <RowResult>[];
    for (var v in variables) {
      var value = v.value;
      if (value is CsvCodable) {
        row = [...row, ...value.toCsvRow()];
      } else {
        row.add(v);
      }
    }
    return row;
  }
}

class WaitingInfo with CsvCodable {
  WaitingInfo({
    @required this.id,
    this.waitTime,
    this.facilitiesData,
    @required this.dateTime,
    this.weatherData,
  });

  final String id;
  final WaitTime waitTime;
  final FacilitiesData facilitiesData;
  final tz.TZDateTime dateTime;
  final WeatherData weatherData;

  @override
  List<RowResult> get variables => [
        RowResult(value: facilitiesData),
        RowResult(value: dateTime.toIso8601String(), variableName: 'time'),
        RowResult(value: waitTime),
        RowResult(value: weatherData),
      ];

  @override
  String toString() {
    return '[waitingInfo: ${facilitiesData.name} - ${waitTime.status}]';
  }

  WaitingInfo copyWith({
    String id,
    WaitTime waitTime,
    FacilitiesData facilitiesData,
    tz.TZDateTime dateTime,
    WeatherData weatherData,
  }) =>
      WaitingInfo(
        id: id ?? this.id,
        facilitiesData: facilitiesData ?? this.facilitiesData,
        waitTime: waitTime ?? this.waitTime,
        dateTime: dateTime ?? this.dateTime,
        weatherData: weatherData ?? this.weatherData,
      );

  factory WaitingInfo.fromJson(
      Map<String, dynamic> json, tz.TZDateTime dateTime, tz.Location location) {
    return WaitingInfo(
      id: json['id'],
      waitTime: WaitTime.fromJson(json['waitTime']),
      dateTime: json['dateTime'] != null
          ? tz.TZDateTime.parse(location, json['dateTime'])
          : dateTime,
      facilitiesData: json['facilitiesData'],
      weatherData: json['weatherData'] != null
          ? WeatherData.fromJson(json['weatherData'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'waitTime': waitTime?.toJson(),
        'dateTime': dateTime.toIso8601String(),
        'facilitiesData': facilitiesData,
        'weatherData': weatherData?.toJson(),
      };

  String get cleanId {
    return getCleanID(id);
  }
}

class WaitTime with CsvCodable {
  WaitTime({
    this.fastPass,
    this.status,
    this.singleRider,
    this.postedWaitMinutes,
  });

  FastPass fastPass;
  String status;
  bool singleRider;
  num postedWaitMinutes;

  @override
  List<RowResult> get variables => [
        RowResult(value: fastPass),
        RowResult(value: status, variableName: 'status'),
        RowResult(value: postedWaitMinutes, variableName: 'wait time')
      ];

  factory WaitTime.fromJson(Map<String, dynamic> json) => WaitTime(
        fastPass: FastPass.fromJson(json['fastPass']),
        status: json['status'],
        singleRider: json['singleRider'],
        postedWaitMinutes: json['postedWaitMinutes'],
      );

  Map<String, dynamic> toJson() => {
        'fastPass': fastPass?.toJson(),
        'status': status,
        'singleRider': singleRider,
        'postedWaitMinutes': postedWaitMinutes,
      };
}

class FastPass with CsvCodable {
  FastPass({
    this.available,
  });

  bool available;

  @override
  List<RowResult> get variables => [
        RowResult(value: available, variableName: 'fastpass-available'),
      ];

  factory FastPass.fromJson(Map<String, dynamic> json) => FastPass(
        available: json['available'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
      };
}
