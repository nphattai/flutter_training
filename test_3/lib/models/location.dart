import 'package:equatable/equatable.dart';

import "coordinates.dart";
import "street.dart";
import "timezone.dart";

class Location extends Equatable {
  final Street street;
  final String city;
  final String state;
  final String country;
  final int postcode;
  final Coordinates coordinates;
  final Timezone timezone;

  const Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });

  @override
  String toString() {
    return 'Location(street: $street, city: $city, state: $state, country: $country, postcode: $postcode, coordinates: $coordinates, timezone: $timezone)';
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: json['street'] == null
          ? null
          : Street.fromJson(json['street'] as Map<String, dynamic>),
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      postcode: json['postcode'] as int,
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      timezone: json['timezone'] == null
          ? null
          : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
    );
  }

  Location copyWith({
    Street street,
    String city,
    String state,
    String country,
    int postcode,
    Coordinates coordinates,
    Timezone timezone,
  }) {
    return Location(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postcode: postcode ?? this.postcode,
      coordinates: coordinates ?? this.coordinates,
      timezone: timezone ?? this.timezone,
    );
  }

  @override
  List<Object> get props {
    return [
      street,
      city,
      state,
      country,
      postcode,
      coordinates,
      timezone,
    ];
  }

  String get address {
    return '${street.number.toStringAsFixed(0)} ${street.name} $city $country';
  }
}
