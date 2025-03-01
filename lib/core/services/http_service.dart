import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _timeout = Duration(seconds: 10);

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    try {
      debugPrint('Making HTTP GET request to $url');

      final uri = Uri.parse(url);
      debugPrint('Formatted URI: $uri');

      final defaultHeaders = {
        'Accept': 'application/json',
        'User-Agent': 'DaymeGame/1.0',
      };

      final mergedHeaders = {...defaultHeaders, ...?headers};

      final response = await _client
          .get(
        uri,
        headers: mergedHeaders,
      )
          .timeout(
        _timeout,
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      debugPrint('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('Response headers: ${response.headers}');
        debugPrint('Response body length: ${response.body.length}');
      } else {
        debugPrint(
            'HTTP request failed with status code: ${response.statusCode}');
        throw HttpException(
            'HTTP request failed with status code: ${response.statusCode}');
      }

      return response;
    } catch (e, stackTrace) {
      debugPrint('Error in HTTP GET request: $e\nURL: $url');
      debugPrint('Stack trace: $stackTrace');
      if (e is FormatException) {
        throw FormatException('Invalid URL format: $url');
      } else if (e is TimeoutException) {
        throw TimeoutException('Request timed out', _timeout);
      }
      rethrow;
    }
  }

  Future<http.Response> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      debugPrint('Making HTTP POST request to $url');
      debugPrint('Request body: $body');

      final uri = Uri.parse(url);
      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'DaymeGame/1.0',
      };

      final mergedHeaders = {...defaultHeaders, ...headers ?? {}};
      final encodedBody = body != null ? json.encode(body) : null;

      final response = await _client
          .post(
        uri,
        body: encodedBody,
        headers: mergedHeaders,
      )
          .timeout(
        _timeout,
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      if (!response.statusCode.toString().startsWith('2')) {
        debugPrint(
            'HTTP request failed with status code: ${response.statusCode}');
        throw HttpException(
            'HTTP request failed with status code: ${response.statusCode}');
      }

      return response;
    } catch (e, stackTrace) {
      debugPrint('Error in HTTP POST request: $e\nURL: $url');
      debugPrint('Stack trace: $stackTrace');
      if (e is FormatException) {
        throw FormatException('Invalid URL format or JSON encoding failed');
      } else if (e is TimeoutException) {
        throw TimeoutException('Request timed out', _timeout);
      }
      rethrow;
    }
  }
}
