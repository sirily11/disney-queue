class WaitingInfo {
  WaitingInfo({
    this.id,
    this.waitTime,
  });

  String? id;
  WaitTime? waitTime;

  factory WaitingInfo.fromJson(Map<String, dynamic> json) => WaitingInfo(
        id: json['id'],
        waitTime: WaitTime.fromJson(json['waitTime']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'waitTime': waitTime?.toJson(),
      };

  String get cleanId {
    if (id != null) {
      var regex = RegExp(r'^([^;]+)');
      var matches = regex.firstMatch(id!);
      if (matches != null) {
        return matches.group(1)!;
      }
    }

    return '';
  }
}

class WaitTime {
  WaitTime({
    this.fastPass,
    this.status,
    this.singleRider,
  });

  FastPass? fastPass;
  String? status;
  bool? singleRider;

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

  bool? available;

  factory FastPass.fromJson(Map<String, dynamic> json) => FastPass(
        available: json['available'],
      );

  Map<String, dynamic> toJson() => {
        'available': available,
      };
}
