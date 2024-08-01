


import 'package:json_annotation/json_annotation.dart';

import 'BaseResponseBody.dart';
part 'CommonResponseBody.g.dart';

@JsonSerializable()
class CommonResponseBody  extends BaseResponseBody{
  String? result;

  CommonResponseBody(bool success, String? message, int code, var timestamp,
      this.result)
      : super(success, message, code, timestamp);

  factory CommonResponseBody.fromJson(Map<String, dynamic> json) => _$CommonResponseBodyFromJson(json);


  Map<String,dynamic> toJson() => _$CommonResponseBodyToJson(this);

}