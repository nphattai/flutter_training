import 'package:equatable/equatable.dart';

class Street extends Equatable {
  final int number;
  final String name;

  const Street({this.number, this.name});

  @override
  String toString() => 'Street(number: $number, name: $name)';

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      number: json['number'] as int,
      name: json['name'] as String,
    );
  }

  Street copyWith({
    int number,
    String name,
  }) {
    return Street(
      number: number ?? this.number,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [number, name];
}
