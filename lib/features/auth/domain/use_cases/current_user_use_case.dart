import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';

@injectable
class CurrentUserUseCase {
  final AuthRepos _authRepos;
  CurrentUserUseCase(this._authRepos);
  Future<ApiResult<UserEntity>>call()async{
    return await _authRepos.getCurrentUser();
  }
}