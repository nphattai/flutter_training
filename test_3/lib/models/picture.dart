import 'package:equatable/equatable.dart';

class Picture extends Equatable {
  final String large;
  final String medium;
  final String thumbnail;

  const Picture({
    this.large,
    this.medium,
    this.thumbnail,
  });

  @override
  String toString() {
    return 'Picture(large: $large, medium: $medium, thumbnail: $thumbnail)';
  }

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'] as String,
      medium: json['medium'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  Picture copyWith({
    String large,
    String medium,
    String thumbnail,
  }) {
    return Picture(
      large: large ?? this.large,
      medium: medium ?? this.medium,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object> get props => [large, medium, thumbnail];
}
