import '../utils/utils.dart';
import 'FacilitiesData.dart';

class WaitingInfo {
  WaitingInfo({
    this.id,
    this.waitTime,
    this.facilitiesData,
  });

  String id;
  WaitTime waitTime;
  FacilitiesData facilitiesData;

  WaitingInfo copyWith({
    String id,
    WaitTime waitTime,
    FacilitiesData facilitiesData,
  }) =>
      WaitingInfo(
        id: id,
        facilitiesData: facilitiesData,
        waitTime: waitTime,
      );

  factory WaitingInfo.fromJson(Map<String, dynamic> json) => WaitingInfo(
        id: json['id'],
        waitTime: WaitTime.fromJson(json['waitTime']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'waitTime': waitTime?.toJson(),
      };

  String get cleanId {
    return getCleanID(id);
  }
}

class WaitTime {
  WaitTime({
    this.fastPass,
    this.status,
    this.singleRider,
  });

  FastPass fastPass;
  String status;
  bool singleRider;

  factory WaitTime.fromJson(Map<String, dynamic> json) => WaitTime(
        fastPass: FastPass.fromJson(json["fastPass"]),
        status: json["status"],
        singleRider: json["singleRider"],
      );

  Map<String, dynamic> toJson() => {
        'fastPass': fastPass?.toJson(),
        'status': status,
        'singleRider': singleRider,
      };
}

class FastPass {
  FastPass({
    this.available,
  });

  bool available;

  factory FastPass.fromJson(Map<String, dynamic> json) => FastPass(
        available: json['available'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
      };
}
