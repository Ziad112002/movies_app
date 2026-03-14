import '../../../../../core/utils/api_result.dart';
import '../../model/remoteUser.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<RemoteUser>> signUp(String email,String password,String name,String phoneNumber,String avatarUrl,);
  Future<ApiResult<void>> login(String email,String password);
  Future<ApiResult<void>> loginWithGoogle();
  Future<ApiResult<void>> logout();
  Future<ApiResult<void>> forgotPass(String email);
  Future<ApiResult<void>> deleteAccount();

  Future<ApiResult<RemoteUser>> getCurrentUser();
  ApiResult<void> updateAccount(String name,String phoneNumber,String avtarPath);

}