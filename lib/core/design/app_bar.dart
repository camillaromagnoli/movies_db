import 'package:flutter/material.dart';

class MoviesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const MoviesAppBar({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      title:
          title != null ? Text(title!, style: textTheme.headlineMedium) : null,
      elevation: 0,
      scrolledUnderElevation: 0,
      forceMaterialTransparency: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
