import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_db_app/core/network/api_routes.dart';
import 'package:movie_db_app/core/network/query_parameters.dart';

import 'injection.config.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(BaseOptions(baseUrl: ApiRoutes.baseUrl));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({
            ApiQueryParams.apiKey: dotenv.env['API_KEY'],
          });
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}

class $RegisterModule extends RegisterModule {}

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
