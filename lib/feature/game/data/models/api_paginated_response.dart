import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_paginated_response.g.dart'; // File Name နာမည်အတိုင်း .g.dart ဖြစ်ရမည်

@JsonSerializable(genericArgumentFactories: true)
class ApiPaginatedResponse<T> {
  @JsonKey(name: 'current_page')
  final int currentPage;
  final List<T> data;

  ApiPaginatedResponse({
    required this.currentPage,
    required this.data,
  });

  factory ApiPaginatedResponse.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,) =>
      _$ApiPaginatedResponseFromJson(json, fromJsonT);

}
