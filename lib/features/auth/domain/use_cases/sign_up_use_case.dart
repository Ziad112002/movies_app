import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';
@injectable
class SignUpUseCase{
  final AuthRepos _authRepos;
  SignUpUseCase(this._authRepos);
  Future<ApiResult<void>>call(String email,String password,String name,String phoneNumber,String avatarUrl,)async{
    return await _authRepos.signUp(email, password, name, phoneNumber, avatarUrl);
}
}