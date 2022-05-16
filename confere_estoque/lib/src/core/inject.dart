import 'package:confere_estoque/src/layers/data/datasources/login_signin_datasource/api/login_signin_api_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/login_signin_datasource/login_signin_datasource.dart';
import 'package:confere_estoque/src/layers/data/datasources/product_get_datasource/api/product_get_api_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/product_get_datasource/product_get_datasource.dart';
import 'package:confere_estoque/src/layers/data/repositories/login_signin_repository_imp.dart';
import 'package:confere_estoque/src/layers/data/repositories/product_repositories/product_get_repository_imp.dart';
import 'package:confere_estoque/src/layers/domain/repositories/login_signing_repository.dart';
import 'package:confere_estoque/src/layers/domain/repositories/product_repositories/product_get_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_signin_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_signin_usecase_imp.dart';
import 'package:confere_estoque/src/layers/domain/usecases/product_usecases/product_get_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/product_usecases/product_get_usecase_imp.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:confere_estoque/src/layers/services/api_service.dart';
import 'package:confere_estoque/src/layers/services/dio/dio_api_service_imp.dart';
import 'package:confere_estoque/src/layers/services/shared_preferences/shared_preferences_service_imp.dart';
import 'package:confere_estoque/src/layers/services/shared_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    //SHARED PREFERENCES
    getIt.registerSingletonAsync<SharedService>(
      () async => SharedPreferencesServiceImp(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    //SERVICES
    getIt.registerLazySingleton<ApiService>(
      () => DioApiServiceImp(
        dio: Dio(),
      ),
    );

    //DATASOURCES
    getIt.registerLazySingleton<LoginSigninDataSource>(
      () => LoginSignInApiDataSourceImp(
        apiService: getIt(),
        sharedService: getIt(),
      ),
    );

    getIt.registerLazySingleton<ProductGetDataSource>(
      () => ProductGetApiDataSourceImp(
        apiService: getIt(),
      ),
    );

    //REPOSITORIES
    getIt.registerLazySingleton<LoginSignInRepository>(
      () => LoginSignInRepositoryImp(loginSigninDataSource: getIt()),
    );

    getIt.registerLazySingleton<ProductGetRepository>(
      () => ProductGetRepositoryImp(productGetDataSource: getIt()),
    );

    //USESCASES
    getIt.registerLazySingleton<LoginSignInUseCase>(
      () => LoginSignInUseCaseImp(loginSignInRepository: getIt()),
    );

    getIt.registerLazySingleton<ProductGetUseCase>(
      () => ProductGetUseCaseImp(productGetRepository: getIt()),
    );

    //BLOCS
    getIt.registerLazySingleton<LoginBloc>(
        () => LoginBloc(loginSignInUseCase: getIt()));

    getIt.registerLazySingleton<ProductBloc>(
        () => ProductBloc(productGetUseCase: getIt()));
  }
}
