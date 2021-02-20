import 'package:equatable/equatable.dart';

class Dob extends Equatable {
  final String date;
  final int age;

  const Dob({this.date, this.age});

  @override
  String toString() => 'Dob(date: $date, age: $age)';

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      date: json['date'] as String,
      age: json['age'] as int,
    );
  }

  Dob copyWith({
    String date,
    int age,
  }) {
    return Dob(
      date: date ?? this.date,
      age: age ?? this.age,
    );
  }

  @override
  List<Object> get props => [date, age];
}
