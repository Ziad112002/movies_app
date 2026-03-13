import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';
@injectable
class LoginUseCase {
  final AuthRepos _authRepos;
  LoginUseCase(this._authRepos);
  Future<ApiResult<void>>call(String email,String password)async{
    return await _authRepos.login(email, password);
  }
}