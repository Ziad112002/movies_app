import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';

import '../../../../core/utils/api_result.dart';

abstract class AuthRepos {
  Future<ApiResult<void>> signUp(String email,String password,String name,String phoneNumber,String avatarUrl,);
  Future<ApiResult<void>> login(String email,String password);
Future<ApiResult<void>>logout();
  Future<ApiResult<UserEntity>>getCurrentUser();
}