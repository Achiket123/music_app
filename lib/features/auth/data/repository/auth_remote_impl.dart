import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/network/connection_checker.dart';
import 'package:music_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:music_app/features/auth/data/models/user_model.dart';
import 'package:music_app/features/auth/domain/repository/auth_repository.dart';
import 'package:music_app/core/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> loginWithEmailandPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource.loginwithEmailPassword(
        email: email, pasword: password));
  }

  @override
  Future<Either<Failure, User>> signUpwithEmailandPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await remoteDataSource.signUpwithEmailPassword(
        name: name, email: email, pasword: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: 'No Internet connection'));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure(message: "User not Logged in"));
        }
        return right(UserModel(
            id: session.user.id, email: session.user.email ?? '', name: ''));
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure(message: 'User Not Logged In'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
