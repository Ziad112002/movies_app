import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';

import '../../../../core/utils/api_result.dart';
@injectable
class ForgotPassUseCase {
  final AuthRepos _authRepos;
  ForgotPassUseCase(this._authRepos);
  Future<ApiResult<void>> call(String email)async{
    return await _authRepos.forgotPass(email);
  }
}