
part of 'init_dependencies.dart';
final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(internetConnection: serviceLocator()));

  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))
    

    // Repository
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator(), serviceLocator()))

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

    // data Source
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()))

    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
       
        serviceLocator(),
        serviceLocator()))

    // usecase
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()))
    // bloc
    ..registerLazySingleton(() =>
        BlogBloc(uploadBlog: serviceLocator(), allBlog: serviceLocator()));
}
