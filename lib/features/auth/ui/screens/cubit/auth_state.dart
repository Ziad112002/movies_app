import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';

class AuthState {
 late Resource<void> signUpServer;
 late Resource<void> loginServer;
 late Resource<void> logoutServer;
 late Resource<UserEntity> currentUserServer;
AuthState({required this.signUpServer, required this.loginServer,required this.logoutServer,required this.currentUserServer});
AuthState.initial(){
  signUpServer=Resource.loading();
  loginServer=Resource.loading();
  logoutServer=Resource.initial();
  currentUserServer=Resource.initial();
}
AuthState copyWith({
   Resource<void>? signUpServer,
   Resource<void>? loginServer,
   Resource<void>? logoutServer,
   Resource<UserEntity>? currentUserServer,
}){
  return AuthState(signUpServer: signUpServer?? this.signUpServer, loginServer: loginServer??this.loginServer,logoutServer: logoutServer??this.logoutServer,currentUserServer: currentUserServer??this.currentUserServer);
}
}