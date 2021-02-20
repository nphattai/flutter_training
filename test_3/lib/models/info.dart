import 'package:equatable/equatable.dart';

class Info extends Equatable {
  final String seed;
  final int results;
  final int page;
  final String version;

  const Info({
    this.seed,
    this.results,
    this.page,
    this.version,
  });

  @override
  String toString() {
    return 'Info(seed: $seed, results: $results, page: $page, version: $version)';
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      seed: json['seed'] as String,
      results: json['results'] as int,
      page: json['page'] as int,
      version: json['version'] as String,
    );
  }

  Info copyWith({
    String seed,
    int results,
    int page,
    String version,
  }) {
    return Info(
      seed: seed ?? this.seed,
      results: results ?? this.results,
      page: page ?? this.page,
      version: version ?? this.version,
    );
  }

  @override
  List<Object> get props => [seed, results, page, version];
}
