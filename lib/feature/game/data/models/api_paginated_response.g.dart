// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_paginated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPaginatedResponse<T> _$ApiPaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiPaginatedResponse<T>(
  currentPage: (json['current_page'] as num).toInt(),
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList()
);

Map<String, dynamic> _$ApiPaginatedResponseToJson<T>(
  ApiPaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'data': instance.data.map(toJsonT).toList()
};
