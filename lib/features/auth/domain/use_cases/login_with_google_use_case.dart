import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';

import '../../../../core/utils/api_result.dart';

@injectable
class LoginWithGoogleUseCase {
  final AuthRepos _authRepos;
  LoginWithGoogleUseCase(this._authRepos);
  Future<ApiResult<void>>call()async{
    return await _authRepos.loginWithGoogle();
  }

}