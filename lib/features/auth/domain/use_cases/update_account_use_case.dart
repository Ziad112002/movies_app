import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';

import '../../../../core/utils/api_result.dart';
@injectable
class UpdateAccountUseCase {
  final AuthRepos _authRepos;
  UpdateAccountUseCase(this._authRepos);
  Future<ApiResult<void>> call(String name,String phoneNumber,String avtarPath)async{
    return await _authRepos.updateAccount(name, phoneNumber, avtarPath) ;
  }
}