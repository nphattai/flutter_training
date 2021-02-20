import 'package:equatable/equatable.dart';

class Registered extends Equatable {
  final String date;
  final int age;

  const Registered({this.date, this.age});

  @override
  String toString() => 'Registered(date: $date, age: $age)';

  factory Registered.fromJson(Map<String, dynamic> json) {
    return Registered(
      date: json['date'] as String,
      age: json['age'] as int,
    );
  }

  Registered copyWith({
    String date,
    int age,
  }) {
    return Registered(
      date: date ?? this.date,
      age: age ?? this.age,
    );
  }

  @override
  List<Object> get props => [date, age];
}
