// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';

import 'client/client_client.dart';

/// Petstore `v1.0`.
/// 
/// A sample API that uses a petstore as an example to demonstrate features in the OpenAPI 3.0 specification.
class ApiMicroservice {
  ApiMicroservice(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  ClientClient? _client;

  ClientClient get client => _client ??= ClientClient(_dio, baseUrl: _baseUrl);
}
