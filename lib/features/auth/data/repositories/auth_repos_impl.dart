import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/core/utils/extensions/connectivity_extension.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/data/mapper/auth_mapper.dart';
import 'package:movies/features/auth/data/repositories/remote_data_source/auth_remote_data_source.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';
import 'package:movies/features/auth/domain/repository/auth_repos.dart';
@Injectable(as: AuthRepos)
class AuthReposImpl extends AuthRepos {
final Connectivity _connectivity;
final AuthMapper _mapper;
final AuthRemoteDataSource _authRemoteDataSource;
AuthReposImpl(this._connectivity,this._mapper,this._authRemoteDataSource);
@override
  Future<ApiResult<void>> signUp(String email,String password,String name,String phoneNumber,String avatarUrl,)async{
if(await _connectivity.isConnected){
  var result=await _authRemoteDataSource.signUp(email, password, name, phoneNumber, avatarUrl);
  if(result.isSuccess){
    return result;
  }else{
    return ErrorApiResult(UnKnownErrors(errorMessage: result.error?.errorMessage ?? "Some thing went Wrong"));
  }
}else{
  return ErrorApiResult(NetworkErrors());
}

}
@override
  Future<ApiResult<void>> login(String email,String password)async{
if(await _connectivity.isConnected){
  var result=await _authRemoteDataSource.login(email, password,);
  if(result.isSuccess){
    return result;
  }else{
    return ErrorApiResult(UnKnownErrors(errorMessage: result.error?.errorMessage ?? "Some thing went Wrong"));
  }
}else{
  return ErrorApiResult(NetworkErrors());
}

}
@override
  Future<ApiResult<void>>logout()async{
  var result= await _authRemoteDataSource.logout();
if(await _connectivity.isConnected){
    if(result.isSuccess){
      return result;
    }else{
      return ErrorApiResult(UnKnownErrors(errorMessage: result.error?.errorMessage ?? "Some thing went Wrong"));
    }
  }else{
    return ErrorApiResult(NetworkErrors());
  }
}
@override
  Future<ApiResult<UserEntity>>getCurrentUser()async{
  if(await _connectivity.isConnected){
    var result= await _authRemoteDataSource.getCurrentUser();
    if(result.isSuccess){
      var currentUser=_mapper.getUser(result.getData()!);
      return SuccessApiResult(currentUser);
    }else{
      return ErrorApiResult(UnKnownErrors(errorMessage: result.error!.errorMessage));
    }

  }else{
    return ErrorApiResult(NetworkErrors());
  }
}
}