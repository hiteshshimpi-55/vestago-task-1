class Success{
  final int? code;
  Object response;
  Success({this.code, required this.response});
}

class Failure{
  final int? code;
  Object errorResponse;
  Failure({this.code, required this.errorResponse});
}

class CommonError {
  final int code;
  final Object message;

  CommonError({required this.code, required this.message});
}