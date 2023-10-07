// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:dio/dio.dart';

import 'clients/client_data_source.dart';

/// Petstore `v1.0`.
/// 
/// A sample API that uses a petstore as an example to demonstrate features in the OpenAPI 3.0 specification.
class RestClient {
  RestClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  ClientDataSource? _client;

  ClientDataSource get client => _client ??= ClientDataSource(_dio, baseUrl: _baseUrl);
}
