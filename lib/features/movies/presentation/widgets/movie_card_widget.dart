import 'package:flutter/material.dart';
import 'package:movie_db_app/core/design/design.dart';
import 'package:movie_db_app/core/utils/utils.dart';
import 'package:movie_db_app/features/movies/data/models/movie_model.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({super.key, required this.movie, required this.onTap});

  final MovieModel movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppBorderRadius.large,
            child: Image.network(
              movie.posterPath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelLarge,
          ),
          Text(
            formatDate(movie.releaseDate),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
