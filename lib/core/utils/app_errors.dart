class AppErrors {
  String errorMessage;
  AppErrors(this.errorMessage);
}

class ServerErrors extends AppErrors {
  ServerErrors({String errorMessage = "Server is down please try again later"})
    : super(errorMessage);
}

class NetworkErrors extends AppErrors {
  NetworkErrors({String errorMessage = "Please check your internet connection"})
    : super(errorMessage);
}

class IgnoredErrors extends AppErrors {
  IgnoredErrors({String errorMessage = ""}) : super(errorMessage);
}

class UnKnownErrors extends AppErrors {
  UnKnownErrors({
    String errorMessage = "Something went wrong please try again later",
  }) : super(errorMessage);
}
