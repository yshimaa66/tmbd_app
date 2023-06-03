import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tmdb_app/core/API/api_client.dart';
import 'package:tmdb_app/core/API/api_consumer.dart';
import 'package:tmdb_app/core/API/api_interceptors.dart';
import 'package:tmdb_app/core/network/network_info.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/local/popular_person_details_LDS.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/local/popular_person_details_LDS_impl.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/remote/popular_person_details_RDS.dart';
import 'package:tmdb_app/features/popular_person_details/data/data_source/remote/popular_person_details_RDS_impl.dart';
import 'package:tmdb_app/features/popular_person_details/data/repository/popular_person_details_repo_impl.dart';
import 'package:tmdb_app/features/popular_person_details/domain/repository/popular_person_details_repo.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_local_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_images_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_movies_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/get_popular_person_tvShows_usecase.dart';
import 'package:tmdb_app/features/popular_person_details/domain/usecases/store_popular_person_details_usecase.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_LDS.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/local/popular_persons_LDS_impl.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_persons_RDS.dart';
import 'package:tmdb_app/features/popular_persons/data/data_source/remote/popular_persons_RDS_impl.dart';
import 'package:tmdb_app/features/popular_persons/data/repository/popular_persons_repo_impl.dart';
import 'package:tmdb_app/features/popular_persons/domain/repository/popular_persons_repo.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_local_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/get_popular_persons_usecase.dart';
import 'package:tmdb_app/features/popular_persons/domain/usecases/store_popular_persons_usecase.dart';

// final sl = GetIt.instance;
//
// class ServicesLocator {
//   void init() {
//     ///GetStorage
//     sl.registerLazySingleton<GetStorage>(() => GetStorage());
//
//     ///NetworkInfo
//     sl.registerLazySingleton<InternetConnectionChecker>(
//         () => InternetConnectionChecker());
//     sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
//
//     ///APIServices
//     sl.registerLazySingleton<AppInterceptors>(() => AppInterceptors());
//     sl.registerLazySingleton<Dio>(() => Dio());
//     sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl<Dio>()));
//
//     initPopularPersons();
//
//     initPopularPersonDetails();
//   }
//
//   void initPopularPersons() {
//     ///PopularPersonsLocalDataSource
//     sl.registerLazySingleton<PopularPersonsLocalDataSource>(
//         () => PopularPersonsLocalDataSourceImpl());
//
//     ///PopularPersonsRemoteDataSource
//     sl.registerLazySingleton<PopularPersonsRemoteDataSource>(
//         () => PopularPersonsRemoteDataSourceImpl(sl()));
//
//     ///PopularPersonsRepo
//     sl.registerLazySingleton<PopularPersonsRepo>(
//         () => PopularPersonsRepoImpl());
//
//     ///PopularPersonsUseCase
//     sl.registerLazySingleton<GetPopularPersonsUseCase>(
//         () => GetPopularPersonsUseCase());
//     sl.registerLazySingleton<StorePopularPersonsUseCase>(
//         () => StorePopularPersonsUseCase());
//     sl.registerLazySingleton<GetLocalPopularPersonsUseCase>(
//         () => GetLocalPopularPersonsUseCase());
//   }
//
//   void initPopularPersonDetails() {
//     ///PopularPersonDetailsLocalDataSource
//     sl.registerLazySingleton<PopularPersonDetailsLocalDataSource>(
//         () => PopularPersonDetailsLocalDataSourceImpl());
//
//     ///PopularPersonDetailsRemoteDataSource
//     sl.registerLazySingleton<PopularPersonDetailsRemoteDataSource>(
//         () => PopularPersonDetailsRemoteDataSourceImpl(sl()));
//
//     ///PopularPersonDetailsRepo
//     sl.registerLazySingleton<PopularPersonDetailsRepo>(
//         () => PopularPersonDetailsRepoImpl());
//
//     ///PopularPersonDetailsUseCase
//     sl.registerLazySingleton<GetPopularPersonDetailsUseCase>(
//         () => GetPopularPersonDetailsUseCase());
//     sl.registerLazySingleton<GetPopularPersonImagesUseCase>(
//             () => GetPopularPersonImagesUseCase());
//     sl.registerLazySingleton<GetPopularPersonMoviesUseCase>(
//             () => GetPopularPersonMoviesUseCase());
//     sl.registerLazySingleton<GetPopularPersonTVShowsUseCase>(
//             () => GetPopularPersonTVShowsUseCase());
//     sl.registerLazySingleton<StorePopularPersonDetailsUseCase>(
//         () => StorePopularPersonDetailsUseCase());
//     sl.registerLazySingleton<GetLocalPopularPersonDetailsUseCase>(
//         () => GetLocalPopularPersonDetailsUseCase());
//   }
// }
