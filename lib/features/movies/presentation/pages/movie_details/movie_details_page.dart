import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/core/design/app_bar.dart';
import 'package:movie_db_app/core/design/tokens/border_radius.dart';
import 'package:movie_db_app/core/design/tokens/spacing.dart';
import 'package:movie_db_app/core/di/injection.dart';
import 'package:movie_db_app/core/utils/app_texts.dart';
import 'package:movie_db_app/core/utils/utils.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:movie_db_app/features/movies/presentation/widgets/movie_error_widget.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create:
          (_) => getIt<MovieDetailsCubit>()..getMovieDetails(movieId: movieId),
      child: Scaffold(
        appBar: MoviesAppBar(),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            final cubit = context.read<MovieDetailsCubit>();

            switch (state.status) {
              case MovieDetailsStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case MovieDetailsStatus.failure:
                return MoviesErrorWidget(
                  errorMessage: AppTexts.serverErrorMessage,
                  onRefresh: () => cubit.getMovieDetails(movieId: movieId),
                );

              case MovieDetailsStatus.success:
                final movie = state.movie!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    spacing: AppSpacing.xs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: AppBorderRadius.large,
                          child: Image.network(
                            movie.backdropPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(movie.title, style: textTheme.headlineMedium),
                      Row(
                        spacing: AppSpacing.xxs,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: AppSpacing.md,
                          ),
                          Text(
                            movie.averageRating.toStringAsFixed(2),
                            style: textTheme.labelLarge,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.overviewTitle,
                            style: textTheme.headlineSmall,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(movie.overview),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.releaseDateTitle,
                            style: textTheme.titleSmall,
                          ),
                          Text(formatDate(movie.releaseDate)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.runtimeTitle,
                            style: textTheme.titleSmall,
                          ),
                          Text(
                            '${movie.runtime} ${AppTexts.minutes}',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
