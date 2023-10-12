import 'dart:convert';

import 'package:http/http.dart' as http;

mixin HttpClientMixin {
  final http.Client _client = http.Client();

  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) {
    return _client.get(url, headers: headers);
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _client.post(url, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _client.put(url, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _client.delete(url,
        headers: headers, body: body, encoding: encoding);
  }
}
