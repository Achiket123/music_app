

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:music_app/core/common/cubit/cubit/app_user_cubit.dart';
import 'package:music_app/core/network/connection_checker.dart';
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
import 'package:music_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:music_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:music_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies.main.dart';