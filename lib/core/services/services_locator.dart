import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tmdb_app/core/API/api_interceptors.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/core/services/api_service.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_person_local_data_source_impl.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_person_remote_data_source_impl.dart';
import 'package:tmdb_app/features/popular_persons/data/repository/popular_persons_repo_impl.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_local_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/store_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/presentation/bloc/popular_persons_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///GetStorage
    sl.registerLazySingleton<GetStorage>(() => GetStorage());

    ///NetworkInfo
    sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

    ///APIServices
    sl.registerLazySingleton<APIService>(() => APIService());
    sl.registerLazySingleton<AppInterceptors>(() => AppInterceptors());

    ///PopularPersonsLocalDataSource
    sl.registerLazySingleton<PopularPersonsLocalDataSource>(
        () => PopularPersonsLocalDataSourceImpl());

    ///PopularPersonsRemoteDataSource
    sl.registerLazySingleton<PopularPersonsRemoteDataSource>(
        () => PopularPersonsRemoteDataSourceImpl(sl()));

    ///PopularPersonsRepo
    sl.registerLazySingleton<PopularPersonsRepo>(
        () => PopularPersonsRepoImpl());

    ///PopularPersonsUseCase
    sl.registerLazySingleton<GetPopularPersonsUseCase>(
        () => GetPopularPersonsUseCase());
    sl.registerLazySingleton<StorePopularPersonsUseCase>(
            () => StorePopularPersonsUseCase());
    sl.registerLazySingleton<GetLocalPopularPersonsUseCase>(
            () => GetLocalPopularPersonsUseCase());
  }
}
