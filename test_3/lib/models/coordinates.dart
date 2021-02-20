import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  const Coordinates({this.latitude, this.longitude});

  final String latitude;
  final String longitude;

  @override
  String toString() {
    return 'Coordinates(latitude: $latitude, longitude: $longitude)';
  }

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
      );

  Coordinates copyWith({
    String latitude,
    String longitude,
  }) =>
      Coordinates(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  @override
  List<Object> get props => [latitude, longitude];
}
