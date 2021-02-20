import 'package:equatable/equatable.dart';

class Id extends Equatable {
  final String name;
  final String value;

  const Id({this.name, this.value});

  @override
  String toString() => 'Id(name: $name, value: $value)';

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  Id copyWith({
    String name,
    String value,
  }) {
    return Id(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  List<Object> get props => [name, value];
}
