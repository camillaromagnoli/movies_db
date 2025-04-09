import 'package:equatable/equatable.dart';
import 'package:movie_db_app/core/network/api_routes.dart';

class MovieDetailsModel extends Equatable {
  final String title;
  final String overview;
  final String releaseDate;
  final int runtime;
  final double averageRating;
  final String backdropPath;

  const MovieDetailsModel({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.averageRating,
    required this.backdropPath,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final backdropPath = json['backdrop_path'] as String?;

    return MovieDetailsModel(
      title: json['title'],
      overview: json['overview'],
      backdropPath: '${ApiRoutes.imageUrl}$backdropPath',
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      averageRating: (json['vote_average'] as num).toDouble(),
    );
  }
  @override
  List<Object?> get props => [
    title,
    overview,
    backdropPath,
    releaseDate,
    runtime,
    averageRating,
  ];
}
