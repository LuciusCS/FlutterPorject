class BaseResponseBody {
  bool? success;

  String? message;

  int? code;

  var timestamp;

  BaseResponseBody(this.success, this.message, this.code, this.timestamp);
}
