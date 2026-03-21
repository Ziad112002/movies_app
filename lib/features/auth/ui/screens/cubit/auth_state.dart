import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';

class AuthState {
  late Resource<void> signUpServer;
  late Resource<void> loginServer;
  late Resource<void> loginWithGoogleServer;
  late Resource<void> logoutServer;
  late Resource<UserEntity> currentUserServer;
  late Resource<void> forgotPassServer;
  late Resource<void> deleteAccountServer;
  late Resource<void> updateAccountServer;
  AuthState({
    required this.signUpServer,
    required this.loginServer,
    required this.logoutServer,
    required this.currentUserServer,
    required this.loginWithGoogleServer,
    required this.forgotPassServer,
    required this.deleteAccountServer,
    required this.updateAccountServer,
  });
  AuthState.initial() {
    signUpServer = Resource.initial();
    loginServer = Resource.initial();
    logoutServer = Resource.initial();
    currentUserServer = Resource.initial();
    loginWithGoogleServer = Resource.initial();
    forgotPassServer = Resource.initial();
    deleteAccountServer = Resource.initial();
    updateAccountServer = Resource.initial();
  }
  AuthState copyWith({
    Resource<void>? signUpServer,
    Resource<void>? loginServer,
    Resource<void>? loginWithGoogleServer,
    Resource<void>? logoutServer,
    Resource<void>? forgotPassServer,
    Resource<UserEntity>? currentUserServer,
    Resource<void>? deleteAccountServer,
    Resource<void>? updateAccountServer,
  }) {
    return AuthState(
      signUpServer: signUpServer ?? this.signUpServer,
      loginServer: loginServer ?? this.loginServer,
      logoutServer: logoutServer ?? this.logoutServer,
      forgotPassServer: forgotPassServer??this.forgotPassServer,
      currentUserServer: currentUserServer ?? this.currentUserServer,
      loginWithGoogleServer: loginWithGoogleServer ?? this.loginWithGoogleServer,
      deleteAccountServer: deleteAccountServer ?? this.deleteAccountServer,
      updateAccountServer: updateAccountServer ?? this.updateAccountServer,
    );
  }
}
