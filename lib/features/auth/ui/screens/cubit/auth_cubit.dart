import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/domain/use_cases/current_user_use_case.dart';
import 'package:movies/features/auth/domain/use_cases/login_use_case.dart';
import 'package:movies/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:movies/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_state.dart';
@injectable
class AuthCubit extends Cubit<AuthState>{
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final CurrentUserUseCase _currentUserUseCase;
  AuthCubit(this._signUpUseCase,this._loginUseCase,this._logoutUseCase,this._currentUserUseCase):super(AuthState(signUpServer: Resource.initial(),loginServer: Resource.initial(),logoutServer: Resource.initial(),currentUserServer: Resource.initial()));
  Future<void>signUp(String email,String password,String name,String phoneNumber,String avatarUrl,)async{
    emit(state.copyWith(signUpServer: Resource.loading()));
    var result=await _signUpUseCase(email,password,name,phoneNumber,avatarUrl);
    if(result.isSuccess){
      emit(state.copyWith(signUpServer:Resource.success(null) ));
    }else{
      emit(state.copyWith(signUpServer: Resource.error(result.error!.errorMessage)));
    }

  }
  Future<void>login(String email,String password)async{
    emit(state.copyWith(signUpServer: Resource.loading()));
    var result=await _loginUseCase(email,password);
    if(result.isSuccess){
      emit(state.copyWith(loginServer:Resource.success(null) ));
    }else{
      emit(state.copyWith(loginServer: Resource.error(result.error!.errorMessage)));
    }

  }
  Future<void>logout()async{
    emit(state.copyWith(logoutServer: Resource.loading()));
    var result=await _logoutUseCase();
    if(result.isSuccess){
      emit(state.copyWith(logoutServer:Resource.success(null) ));
    }else{
      emit(state.copyWith(logoutServer: Resource.error(result.error!.errorMessage)));
    }

  }
  Future<void>getCurrentUser()async{
    emit(state.copyWith(currentUserServer: Resource.loading()));
    var result=await _currentUserUseCase();
    if(result.isSuccess){
emit(state.copyWith(currentUserServer: Resource.success(result.getData())));
    }else{
      emit(state.copyWith(currentUserServer: Resource.error(result.error!.errorMessage)));
    }
  }
}