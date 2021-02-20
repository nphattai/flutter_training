import 'package:equatable/equatable.dart';

import "info.dart";
import "results.dart";

class User extends Equatable {
  final List<Results> results;
  final Info info;

  const User({this.results, this.info});

  @override
  String toString() => 'User(results: $results, info: $info)';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      results: (json['results'] as List<dynamic>)?.map((dynamic e) {
        return e == null ? null : Results.fromJson(e as Map<String, dynamic>);
      })?.toList(),
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
    );
  }

  User copyWith({
    List<Results> results,
    Info info,
  }) {
    return User(
      results: results ?? this.results,
      info: info ?? this.info,
    );
  }

  @override
  List<Object> get props => [results, info];
}
