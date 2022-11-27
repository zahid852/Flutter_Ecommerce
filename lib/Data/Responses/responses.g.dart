// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatResponse _$CatResponseFromJson(Map<String, dynamic> json) => CatResponse(
      json['cat_name'] as String?,
      json['cat_des'] as String?,
      json['cat_image_url'] as String?,
      json['cat_parameter'] as int?,
    );

Map<String, dynamic> _$CatResponseToJson(CatResponse instance) =>
    <String, dynamic>{
      'cat_name': instance.names,
      'cat_des': instance.des,
      'cat_image_url': instance.imageUrl,
      'cat_parameter': instance.parameter,
    };
