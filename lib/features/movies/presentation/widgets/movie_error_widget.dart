import 'package:flutter/material.dart';
import 'package:movie_db_app/core/design/tokens/spacing.dart';
import 'package:movie_db_app/core/utils/app_texts.dart';

class MoviesErrorWidget extends StatelessWidget {
  const MoviesErrorWidget({
    required this.errorMessage,
    required this.onRefresh,
    super.key,
  });

  final String errorMessage;
  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.xxs,
      children: [
        Text(errorMessage, style: textTheme.bodyLarge),
        TextButton(onPressed: onRefresh, child: Text(AppTexts.tryAgainMessage)),
      ],
    );
  }
}
