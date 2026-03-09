enum AppStatus { initial, loading, success, error }

class Resource<T> {
  T? data;
  String? errorMessage;
  AppStatus? status;
  Resource(this.errorMessage, this.data, this.status);
  Resource.success(this.data) {
    status = AppStatus.success;
  }
  Resource.loading() {
    status = AppStatus.loading;
  }
  Resource.error(String error) {
    errorMessage = error;
    status = AppStatus.error;
  }
  Resource.initial() {
    status = AppStatus.initial;
  }
  bool get isSuccess=>status==AppStatus.success;
  bool get isLoading=>status==AppStatus.loading;
}
