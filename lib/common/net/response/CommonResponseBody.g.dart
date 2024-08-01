// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommonResponseBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponseBody _$CommonResponseBodyFromJson(Map<String, dynamic> json) =>
    CommonResponseBody(
      json['success'] as bool,
      json['message'] as String?,
      (json['code'] as num).toInt(),
      json['timestamp'],
      json['result'] as String?,
    );

Map<String, dynamic> _$CommonResponseBodyToJson(CommonResponseBody instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'timestamp': instance.timestamp,
      'result': instance.result,
    };
