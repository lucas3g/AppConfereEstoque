import 'package:confere_estoque/src/layers/data/datasources/ccustos_datasource/api/ccustos_get_all_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/ccustos_datasource/ccustos_get_all_datasource.dart';
import 'package:confere_estoque/src/layers/data/datasources/estoque_datasource/api/update_estoque_api_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/estoque_datasource/update_estoque_datasource.dart';
import 'package:confere_estoque/src/layers/data/datasources/login_datasource/api/login_signin_api_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/login_datasource/local/login_logout_local_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/login_datasource/login_logout_datasource.dart';
import 'package:confere_estoque/src/layers/data/datasources/login_datasource/login_signin_datasource.dart';
import 'package:confere_estoque/src/layers/data/datasources/product_datasource/api/product_get_api_datasource_imp.dart';
import 'package:confere_estoque/src/layers/data/datasources/product_datasource/product_get_datasource.dart';
import 'package:confere_estoque/src/layers/data/repositories/ccustos_repositories/ccustos_get_all_repository_imp.dart';
import 'package:confere_estoque/src/layers/data/repositories/estoque_repositories/update_estoque_repository.dart';
import 'package:confere_estoque/src/layers/data/repositories/login_repositories/login_logout_repository_imp.dart';
import 'package:confere_estoque/src/layers/data/repositories/login_repositories/login_signin_repository_imp.dart';
import 'package:confere_estoque/src/layers/data/repositories/product_repositories/product_get_repository_imp.dart';
import 'package:confere_estoque/src/layers/domain/repositories/ccustos_repositories/ccustos_get_all_repository.dart';
import 'package:confere_estoque/src/layers/domain/repositories/estoque_repositories/update_estoque_repository.dart';
import 'package:confere_estoque/src/layers/domain/repositories/login_repositories/login_logout_repository.dart';
import 'package:confere_estoque/src/layers/domain/repositories/login_repositories/login_signing_repository.dart';
import 'package:confere_estoque/src/layers/domain/repositories/product_repositories/product_get_repository.dart';
import 'package:confere_estoque/src/layers/domain/usecases/ccustos_usecases/ccustos_get_all_usecases.dart';
import 'package:confere_estoque/src/layers/domain/usecases/ccustos_usecases/ccustos_get_all_usecases_imp.dart';
import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/update_estoque_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/estoque_usecases/update_estoque_usecase_imp.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_logout_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_logout_usecase_imp.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_signin_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/login_usecases/login_signin_usecase_imp.dart';
import 'package:confere_estoque/src/layers/domain/usecases/product_usecases/product_get_usecase.dart';
import 'package:confere_estoque/src/layers/domain/usecases/product_usecases/product_get_usecase_imp.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/ccustos_bloc/ccustos_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/estoque_bloc/estoque_bloc.dart';
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

    getIt.registerLazySingleton<LoginLogOutDataSource>(
      () => LoginLogOutLocalDataSourceImp(
        sharedService: getIt(),
      ),
    );

    getIt.registerLazySingleton<ProductGetDataSource>(
      () => ProductGetApiDataSourceImp(
        apiService: getIt(),
      ),
    );

    getIt.registerLazySingleton<CCustosGetAllDataSource>(
      () => CCustosGetAllApiDataSourceImp(
        apiService: getIt(),
      ),
    );

    getIt.registerLazySingleton<UpdateEstoqueDataSource>(
      () => UpdateEstoqueApiDataSourceImp(
        apiService: getIt(),
      ),
    );

    //REPOSITORIES
    getIt.registerLazySingleton<LoginSignInRepository>(
      () => LoginSignInRepositoryImp(loginSigninDataSource: getIt()),
    );

    getIt.registerLazySingleton<LoginLogOutRepository>(
      () => LoginLogOutRepositoryImp(loginLogOutDataSource: getIt()),
    );

    getIt.registerLazySingleton<ProductGetRepository>(
      () => ProductGetRepositoryImp(productGetDataSource: getIt()),
    );

    getIt.registerLazySingleton<CCustosGetAllRepository>(
      () => CCustosGetAllRepositoryImp(ccustosGetAllDataSource: getIt()),
    );

    getIt.registerLazySingleton<UpdateEstoqueRepository>(
      () => UpdateEstoqueRepositoryImp(updateEstoqueDataSource: getIt()),
    );

    //USESCASES
    getIt.registerLazySingleton<LoginSignInUseCase>(
      () => LoginSignInUseCaseImp(loginSignInRepository: getIt()),
    );

    getIt.registerLazySingleton<LoginLogOutUseCase>(
      () => LoginLogOutUseCaseImp(loginLogOutRepository: getIt()),
    );

    getIt.registerLazySingleton<ProductGetUseCase>(
      () => ProductGetUseCaseImp(productGetRepository: getIt()),
    );

    getIt.registerLazySingleton<CCustosGetAllUseCase>(
      () => CCustosGetAllUseCasesImp(ccustosGetAllRepository: getIt()),
    );

    getIt.registerLazySingleton<UpdateEstoqueUseCase>(
      () => UpdateEstoqueUseCaseImp(updateEstoqueRepository: getIt()),
    );

    //BLOCS
    getIt.registerLazySingleton<LoginBloc>(
      () => LoginBloc(
        loginSignInUseCase: getIt(),
        loginLogOutUseCase: getIt(),
      ),
    );

    getIt.registerLazySingleton<ProductBloc>(
      () => ProductBloc(
        productGetUseCase: getIt(),
      ),
    );

    getIt.registerLazySingleton<CCustosBloc>(
      () => CCustosBloc(
        ccustosGetAllUseCase: getIt(),
        ccusto: 0,
      ),
    );

    getIt.registerLazySingleton<EstoqueBloc>(
      () => EstoqueBloc(
        updateEstoqueUseCase: getIt(),
        estoques: Estoques.contabil,
      ),
    );
  }
}
