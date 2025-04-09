import 'package:equatable/equatable.dart';
import 'package:movie_db_app/core/network/api_routes.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;

  const MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final posterPath = json['poster_path'] as String?;

    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: '${ApiRoutes.imageUrl}$posterPath',
      releaseDate: json['release_date'],
    );
  }

  @override
  List<Object?> get props => [title, posterPath, releaseDate];
}
