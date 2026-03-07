import 'package:movies/core/utils/app_errors.dart';

sealed class ApiResult<T> {}
class SuccessApiResult<T> extends ApiResult<T>{
  T? data;
  SuccessApiResult(this.data);
}class ErrorApiResult<T> extends ApiResult<T>{
AppErrors? errors;
  ErrorApiResult(this.errors);
}