import 'package:flutter/material.dart';
import 'package:movie_db_app/core/di/injection.dart';
import 'package:movie_db_app/core/routes/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'MovieDB App',
      theme: ThemeData(useMaterial3: true),
    );
  }
}
