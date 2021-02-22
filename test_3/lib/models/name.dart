import 'package:equatable/equatable.dart';

class Name extends Equatable {
  final String title;
  final String first;
  final String last;

  const Name({
    this.title,
    this.first,
    this.last,
  });

  @override
  String toString() {
    return 'Name(title: $title, first: $first, last: $last)';
  }

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'] as String,
      first: json['first'] as String,
      last: json['last'] as String,
    );
  }

  Name copyWith({
    String title,
    String first,
    String last,
  }) {
    return Name(
      title: title ?? this.title,
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }

  @override
  List<Object> get props => [title, first, last];

  String get fullName {
    return '$first $last';
  }
}
