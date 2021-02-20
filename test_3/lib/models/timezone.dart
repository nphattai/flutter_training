import 'package:equatable/equatable.dart';

class Timezone extends Equatable {
  final String offset;
  final String description;

  const Timezone({this.offset, this.description});

  @override
  String toString() {
    return 'Timezone(offset: $offset, description: $description)';
  }

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      offset: json['offset'] as String,
      description: json['description'] as String,
    );
  }

  Timezone copyWith({
    String offset,
    String description,
  }) {
    return Timezone(
      offset: offset ?? this.offset,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [offset, description];
}
