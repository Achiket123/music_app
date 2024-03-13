import 'dart:developer';

import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpwithEmailPassword(
      {required String name, required String email, required String pasword});

  Future<UserModel> loginwithEmailPassword(
      {required String email, required String pasword});

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> signUpwithEmailPassword(
      {required String name,
      required String email,
      required String pasword}) async {
    log('message');
    try {
      final response = await supabaseClient.auth
          .signUp(password: pasword, email: email, data: {"name": name});
      if (response.user == null) {
        throw const ServerException('User is null');
      }
      log(response.user!.toString());
      return UserModel.fromJson(response.user!.toJson()).copyWith();
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginwithEmailPassword(
      {required String email, required String pasword}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: pasword, email: email);
      if (response.user == null) {
        throw const ServerException('User is null');
      }

      return UserModel.fromJson(response.user!.toJson()).copyWith();
    }on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    }  catch (e) {
      throw ServerException(e.toString());
    }
  }
}
