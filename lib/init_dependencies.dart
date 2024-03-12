import 'package:get_it/get_it.dart';
import 'package:music_app/core/common/cubit/cubit/app_user_cubit.dart';
import 'package:music_app/core/secrets/app_secerts.dart';
import 'package:music_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:music_app/features/auth/data/repository/auth_remote_impl.dart';
import 'package:music_app/features/auth/domain/usecases/current_user.dart';
import 'package:music_app/features/auth/domain/usecases/user_log_in.dart';
import 'package:music_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:music_app/features/auth/domain/repository/auth_repository.dart';
import 'package:music_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:music_app/features/blog/data/datasources/blog_remot_data_source.dart';
import 'package:music_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:music_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:music_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:music_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))

    // Repository
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))

    // Usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))

    // bloc
    ..registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()));
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()))
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(blogRemoteDataSource: serviceLocator()))
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(serviceLocator()));
}
