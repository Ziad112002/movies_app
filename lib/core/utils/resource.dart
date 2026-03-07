enum AppStatus { initial, loading, success, error }

class Resource<T> {
  T? data;
  bool isLoading = false;
  String? errorMessage;
  AppStatus? status;
  Resource(this.errorMessage, this.isLoading, this.data, this.status);
  Resource.success(this.data) {
    status = AppStatus.success;
  }
  Resource.loading() {
    isLoading = true;
    status = AppStatus.loading;
  }
  Resource.error(String error) {
    errorMessage = error;
    status = AppStatus.error;
  }
  Resource.initial() {
    status = AppStatus.initial;
  }
}
