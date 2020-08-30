import '../utils/utils.dart';

class FacilitiesData {
  FacilitiesData({
    this.id,
    this.type,
    this.cacheId,
    this.name,
    this.ancestors,
    this.relatedLocations,
    this.medias,
    this.descriptions,
    this.subType,
    this.fastPass,
    this.webLink,
    this.duration,
  });

  String id;
  String type;
  String cacheId;
  String name;
  List<Ancestor> ancestors;
  List<RelatedLocation> relatedLocations;
  List<Media> medias;
  List<Description> descriptions;
  String subType;
  String fastPass;
  String webLink;
  String duration;

  String get cleanId {
    return getCleanID(id);
  }

  factory FacilitiesData.fromJson(Map<String, dynamic> json) => FacilitiesData(
        id: json['id'],
        type: json['type'],
        cacheId: json['cacheId'],
        name: json['name'],
        ancestors: List<Ancestor>.from(
            json['ancestors'].map((x) => Ancestor.fromJson(x))),
        relatedLocations: List<RelatedLocation>.from(
            json['relatedLocations'].map((x) => RelatedLocation.fromJson(x))),
        medias: List<Media>.from(json['medias'].map((x) => Media.fromJson(x))),
        descriptions: List<Description>.from(
            json['descriptions'].map((x) => Description.fromJson(x))),
        subType: json['subType'],
        fastPass: json['fastPass'],
        webLink: json['webLink'],
        duration: json['duration'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'cacheId': cacheId,
        'name': name,
        'ancestors':
            List<dynamic>.from(ancestors?.map((x) => x.toJson()) ?? []),
        'relatedLocations':
            List<dynamic>.from(relatedLocations?.map((x) => x.toJson()) ?? []),
        'medias': List<dynamic>.from(medias?.map((x) => x.toJson()) ?? []),
        'descriptions':
            List<dynamic>.from(descriptions?.map((x) => x.toJson()) ?? []),
        'subType': subType,
        'fastPass': fastPass,
        'webLink': webLink,
        'duration': duration,
      };
}

class Ancestor {
  Ancestor({
    this.id,
    this.type,
  });

  String id;
  String type;

  factory Ancestor.fromJson(Map<String, dynamic> json) => Ancestor(
        id: json['id'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}

class Description {
  Description({
    this.type,
    this.text,
  });

  String type;
  String text;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        type: json['type'],
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
      };
}

class Media {
  Media({
    this.type,
    this.url,
  });

  String type;
  String url;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json['type'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
      };
}

class RelatedLocation {
  RelatedLocation({
    this.id,
    this.type,
    this.name,
    this.coordinates,
    this.ancestors,
  });

  String id;
  String type;
  String name;
  List<Coordinate> coordinates;
  List<Ancestor> ancestors;

  factory RelatedLocation.fromJson(Map<String, dynamic> json) =>
      RelatedLocation(
        id: json['id'],
        type: json['type'],
        name: json['name'],
        coordinates: List<Coordinate>.from(
            json['coordinates']?.map((x) => Coordinate.fromJson(x))),
        ancestors: List<Ancestor>.from(
            json['ancestors']?.map((x) => Ancestor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'coordinates':
            List<dynamic>.from(coordinates?.map((x) => x.toJson()) ?? []),
        'ancestors':
            List<dynamic>.from(ancestors?.map((x) => x.toJson()) ?? []),
      };
}

class Coordinate {
  Coordinate({
    this.latitude,
    this.longitude,
    this.type,
  });

  String latitude;
  String longitude;
  String type;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        latitude: json['latitude'],
        longitude: json['longitude'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
      };
}
