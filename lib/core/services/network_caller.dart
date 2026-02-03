import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../models/network_response.dart';

class NetworkCaller {
  final String _defaultErrorMessage = 'Something went wrong';
  final String _unAuthorizedErrorMessage = 'un-authorized';
  final Logger _logger = Logger();

  final VoidCallback onUnAuthorized;
  // CHANGE 1: AccessToken is now a function, not a fixed string
  final String Function() accessToken;

  NetworkCaller({required this.onUnAuthorized, required this.accessToken});

  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      // CHANGE 2: Call the function with () to get the current token
      final Map<String, String> headers = {'token': accessToken()};

      _logRequest('GET', url, null, headers);

      Response response = await get(uri, headers: headers);

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: true,
          statusCode: response.statusCode,
          body: decodedJson,
          errorMessage: '',
        );
      } else if (response.statusCode == 401) {
        onUnAuthorized();
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: false,
          statusCode: response.statusCode,
          body: {},
          errorMessage:
              decodedJson['data']?.toString() ?? _unAuthorizedErrorMessage,
        );
      } else {
        // CHANGE 3: Smart Error Parsing
        return _handleErrorResponse(response);
      }
    } catch (e) {
      return NetworkResponse(
        success: false,
        statusCode: -1,
        body: {},
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic>? body,
    bool isFromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      // CHANGE 2: Call accessToken()
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': accessToken(),
      };

      _logRequest('POST', url, body, headers);

      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: true,
          statusCode: response.statusCode,
          body: decodedJson,
          errorMessage: '',
        );
      } else if (response.statusCode == 401) {
        if (isFromLogin == false) {
          onUnAuthorized();
        }
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: false,
          statusCode: response.statusCode,
          body: {},
          errorMessage:
              decodedJson['data']?.toString() ?? _unAuthorizedErrorMessage,
        );
      } else {
        // CHANGE 3: Smart Error Parsing
        return _handleErrorResponse(response);
      }
    } catch (e) {
      return NetworkResponse(
        success: false,
        statusCode: -1,
        body: {},
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> patchRequest({
    required String url,
    required Map<String, dynamic>? body,
    bool isFromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      // CHANGE 2: Call accessToken()
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': accessToken(),
      };

      _logRequest('PATCH', url, body, headers);

      Response response = await patch(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: true,
          statusCode: response.statusCode,
          body: decodedJson,
          errorMessage: '',
        );
      } else if (response.statusCode == 401) {
        if (isFromLogin == false) {
          onUnAuthorized();
        }
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: false,
          statusCode: response.statusCode,
          body: {},
          errorMessage:
              decodedJson['data']?.toString() ?? _unAuthorizedErrorMessage,
        );
      } else {
        // CHANGE 3: Smart Error Parsing
        return _handleErrorResponse(response);
      }
    } catch (e) {
      return NetworkResponse(
        success: false,
        statusCode: -1,
        body: {},
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> putRequest({
    required String url,
    required Map<String, dynamic>? body,
    bool isFromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      // CHANGE 2: Call accessToken()
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': accessToken(),
      };

      _logRequest('PUT', url, body, headers);

      Response response = await put(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: true,
          statusCode: response.statusCode,
          body: decodedJson,
          errorMessage: '',
        );
      } else if (response.statusCode == 401) {
        if (isFromLogin == false) {
          onUnAuthorized();
        }
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: false,
          statusCode: response.statusCode,
          body: {},
          errorMessage:
              decodedJson['data']?.toString() ?? _unAuthorizedErrorMessage,
        );
      } else {
        // CHANGE 3: Smart Error Parsing
        return _handleErrorResponse(response);
      }
    } catch (e) {
      return NetworkResponse(
        success: false,
        statusCode: -1,
        body: {},
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteRequest({
    required String url,
    required Map<String, dynamic>? body,
    bool isFromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      // CHANGE 2: Call accessToken()
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': accessToken(),
      };

      _logRequest('DELETE', url, body, headers);

      Response response = await delete(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: true,
          statusCode: 200,
          body: decodedJson,
          errorMessage: '',
        );
      } else if (response.statusCode == 204) {
        // Handle 204 separately because it has NO BODY to decode
        return NetworkResponse(
          success: true,
          statusCode: 204,
          body: {},
          errorMessage: '',
        );
      } else if (response.statusCode == 401) {
        if (isFromLogin == false) {
          onUnAuthorized();
        }
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          success: false,
          statusCode: response.statusCode,
          body: {},
          errorMessage:
              decodedJson['data']?.toString() ?? _unAuthorizedErrorMessage,
        );
      } else {
        // CHANGE 3: Smart Error Parsing
        return _handleErrorResponse(response);
      }
    } catch (e) {
      return NetworkResponse(
        success: false,
        statusCode: -1,
        body: {},
        errorMessage: e.toString(),
      );
    }
  }

  // Helper method to extract meaningful error messages
  NetworkResponse _handleErrorResponse(Response response) {
    final decodedJson = jsonDecode(response.body);
    String errorMsg = _defaultErrorMessage;

    if (decodedJson is Map<String, dynamic>) {
      if (decodedJson.containsKey('data')) {
        errorMsg = decodedJson['data'].toString();
      } else if (decodedJson.containsKey('msg')) {
        errorMsg = decodedJson['msg'].toString();
      } else if (decodedJson.containsKey('message')) {
        errorMsg = decodedJson['message'].toString();
      } else if (decodedJson.containsKey('error')) {
        errorMsg = decodedJson['error'].toString();
      }
    }

    return NetworkResponse(
      success: false,
      statusCode: response.statusCode,
      body: {},
      errorMessage: errorMsg,
    );
  }

  void _logRequest(
    String method,
    String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ) {
    _logger.i(
      '========== Request =========='
      '\nMethod: $method'
      '\nURL: $url'
      '\nHeaders: ${headers?.toString() ?? 'No headers'}'
      '\nBody: ${body?.toString() ?? 'No body'}'
      '\n=============================',
    );
  }

  void _logResponse(String url, Response response) {
    _logger.i(
      '========== Response =========='
      '\nURL: $url'
      '\nStatus Code: ${response.statusCode}'
      '\nBody: ${response.body}'
      '\n==============================',
    );
  }
}
