/*
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../helper/constants.dart';
import '../helper/logger.dart';

/// Callback for successful API response
/// `T data` = parsed data, `int status` = API status code (0,1,200, etc.)
//typedef OnSuccess<T> = void Function(T data, int status);
typedef OnSuccess<T> = void Function(T data, int status);

/// Callback for API error or network failure
typedef OnFailure = void Function(ApiException error);

/// Callback for upload progress
typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

/// Supported HTTP methods
enum HttpMethod { get, post, put, delete, patch, head, options, trace, connect }

/// Custom API Exception for better error handling
class ApiException implements Exception {
  final String message;
  final int? code;
  ApiException(this.message, {this.code});

  @override
  String toString() => 'ApiException(code: $code, message: $message)';
}

class Webservice {
  static const _timeout = Duration(seconds: 20);

  static Future<void> postRequest<T>({
    required String uri,
    Object? body,
    bool hasBearer = false,
    required T Function(Map<String, dynamic> json) fromJson,
    required OnSuccess<T> onSuccess,
    required OnFailure onFailure,
  }) async {
    try {
      final response = await Webservice.request<T>(
        uri: uri,
        method: HttpMethod.post,
        body: body,
        hasBearer: hasBearer,
        fromJson: fromJson,
      );
      if (response is Map<String, dynamic>) {
        print("Status: ${response['status']}");
      } else {
        print("Response is not a valid JSON map");
      }

      print("Response - >>>>>>>>: $response.data");
      //final status = response?.data['status'] ?? 0;
      //print("Status: ${response!.status}");

      onSuccess(response, 1);
    } on ApiException catch (e) {
      onFailure(e);
    } catch (e) {
      onFailure(ApiException(e.toString()));
    }
  }

  static Future<void> fileUploadRequest<T>({
    required String uri,
    required File file,
    required String fileFieldName,
    Map<String, String>? body,
    bool hasBearer = false,
    OnUploadProgressCallback? onProgress,
    required T Function(Map<String, dynamic> json) fromJson,
    required OnSuccess<T> onSuccess,
    required OnFailure onFailure,
  }) async {
    try {
      final url = Uri.parse(Global.baseUrl + uri);
      final request = http.MultipartRequest('POST', url);

      if (hasBearer) request.headers.addAll(_headers(hasBearer: true));
      if (body != null) request.fields.addAll(body);

      if (file.path.isNotEmpty) {
        final totalBytes = await file.length();
        int sentBytes = 0;

        final stream = http.ByteStream(
          file.openRead().transform(
            StreamTransformer.fromHandlers(
              handleData: (chunk, sink) {
                sentBytes += chunk.length;
                onProgress?.call(sentBytes, totalBytes);
                sink.add(chunk);
              },
            ),
          ),
        );

        final multipartFile = http.MultipartFile(
          fileFieldName,
          stream,
          totalBytes,
          filename: basename(file.path),
        );

        request.files.add(multipartFile);
      }

      final responseStream = await request.send().timeout(_timeout);
      final responseString = await responseStream.stream.bytesToString();

      Map<String, dynamic> data;
      try {
        data = jsonDecode(responseString);
      } catch (_) {
        throw ApiException("Invalid server response");
      }

      Log.displayResponse(
        payload: body,
        res: responseString,
        requestType: 'UPLOAD',
      );

      final status = data['status'] ?? 0;
      final parsedData = fromJson(data);

      if (status == 1 || status == 200) {
        onSuccess(parsedData, status);
      } else {
        final msg = data['message'] ?? "Upload failed";
        // if (AppStorages.isInternetConnected.value) {
        //   getSnackToast(
        //     message: msg,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.red,
        //     duration: const Duration(seconds: 5),
        //   );
        //   print("On Success"),
        // }
        onFailure(ApiException(msg, code: status));
      }
    } on TimeoutException {
      onFailure(ApiException("Upload request timed out"));
    } catch (e) {
      if (kDebugMode) print("Upload error: $e");
      onFailure(ApiException(e.toString()));
    }
  }

  /// Common headers
  static Map<String, String> _headers({bool hasBearer = false}) {
    final headers = {
      'Content-Type': 'application/json',
      'secretKey': '6eCtSW8ssqGCeRyoKN29',
    };

    if (hasBearer) {
      headers['Authorization'] = "Bearer {AppStorages.accessToken}";
    }
    return headers;
  }

  /// Centralized request handler
  static Future<T> request<T>({
    required String uri,
    required HttpMethod method,
    Map<String, String>? queryParams,
    Object? body,
    bool hasBearer = false,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    final url = Uri.parse(
      Global.baseUrl + uri,
    ).replace(queryParameters: queryParams);
    final headers = _headers(hasBearer: hasBearer);

    try {
      late http.Response response;

      switch (method) {
        case HttpMethod.post:
          response = await http
              .post(
                url,
                headers: headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(_timeout);
          break;

        case HttpMethod.get:
          response = await http.get(url, headers: headers).timeout(_timeout);
          break;

        case HttpMethod.put:
          response = await http
              .put(
                url,
                headers: headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(_timeout);
          break;

        case HttpMethod.delete:
          response = await http
              .delete(
                url,
                headers: headers,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(_timeout);
          break;

        default:
          throw ApiException("Unsupported HTTP method: $method");
      }

      Log.displayResponse(
        payload: body,
        res: response,
        requestType: method.name,
      );

      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (_) {
        throw ApiException("Invalid JSON response", code: response.statusCode);
      }

      // Session expired
      if (data['status'] == -1) {
        // AppStorages.box.erase();
        // Get.offAllNamed(Routes.LOGIN);
        throw ApiException("Session expired");
      }

      // Success
      if (data['status'] == 1 || data['status'] == 200) {
        return fromJson(data);
      } else {
        final msg = data['message'] ?? "Unknown error";
        // if (AppStorages.isInternetConnected.value) {
        //   getSnackToast(
        //     message: msg,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.red,
        //     duration: const Duration(seconds: 5),
        //   );
        // }
        throw ApiException(msg, code: data['status']);
      }
    } on TimeoutException {
      throw ApiException("Request timed out");
    } catch (e) {
      if (kDebugMode) {
        print("Request error: $e");
      }
      rethrow;
    }
  }

  /// Upload file with optional progress callback
  static Future<T> uploadFile<T>({
    required String uri,
    required File file,
    required String fileFieldName,
    Map<String, String>? body,
    bool hasBearer = false,
    OnUploadProgressCallback? onProgress,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    final url = Uri.parse(Global.baseUrl + uri);
    final request = http.MultipartRequest('POST', url);

    if (hasBearer) request.headers.addAll(_headers(hasBearer: true));
    if (body != null) request.fields.addAll(body);

    if (file.path.isNotEmpty) {
      final totalBytes = await file.length();
      int sentBytes = 0;

      final stream = http.ByteStream(
        file.openRead().transform(
          StreamTransformer.fromHandlers(
            handleData: (chunk, sink) {
              sentBytes += chunk.length;
              onProgress?.call(sentBytes, totalBytes);
              sink.add(chunk);
            },
          ),
        ),
      );

      final multipartFile = http.MultipartFile(
        fileFieldName,
        stream,
        totalBytes,
        filename: basename(file.path),
      );

      request.files.add(multipartFile);
    }

    try {
      final responseStream = await request.send().timeout(_timeout);
      final responseString = await responseStream.stream.bytesToString();

      Map<String, dynamic> data;
      try {
        data = jsonDecode(responseString);
      } catch (_) {
        throw ApiException("Invalid server response");
      }

      Log.displayResponse(
        payload: body,
        res: responseString,
        requestType: 'UPLOAD',
      );

      if (data['status'] == -1) {
        // AppStorages.box.erase();
        // Get.offAllNamed(Routes.LOGIN);
        throw ApiException("Session expired");
      }

      if (data['status'] == 1 || data['status'] == 200) {
        return fromJson(data);
      } else {
        final msg = data['message'] ?? "Upload failed";
        // if (AppStorages.isInternetConnected.value) {
        //   getSnackToast(
        //     message: msg,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.red,
        //     duration: const Duration(seconds: 5),
        //   );
        // }
        throw ApiException(msg, code: data['status']);
      }
    } on TimeoutException {
      throw ApiException("Upload request timed out");
    } catch (e) {
      if (kDebugMode) {
        print("Upload error: $e");
      }
      rethrow;
    }
  }
}

/// Call request
// await Webservice.postRequest(
// uri: 'user/login',
// body: {
// "email": "test@gmail.com",
// "password": "123456",
// },
// hasBearer: false,
// fromJson: (json) => json, // or map to your model
// onSuccess: (data, status) {
// if (status == 1) {
// print("Login Successful: $data");
// // Save token, navigate to home, etc.
// } else if (status == 0) {
// print("Login Failed but handled in success: $data");
// // Show toast for invalid credentials, etc.
// }
// },
// onFailure: (error) {
// print("API Error: ${error.message}");
// // Show network error toast or dialog
// },
// );

// File imageFile = File('/path/to/image.jpg');
//
// await Webservice.fileUploadRequest(
// uri: 'user/upload',
// file: imageFile,
// fileFieldName: 'file',
// body: {'user_id': '101'},
// hasBearer: true,
// onProgress: (sent, total) {
// double progress = (sent / total) * 100;
// print("Upload Progress: ${progress.toStringAsFixed(2)}%");
// },
// fromJson: (json) => json, // or your model parser
// onSuccess: (data, status) {
// if (status == 1) {
// print("Upload Successful: $data");
// } else {
// print("Upload returned status $status: $data");
// }
// },
// onFailure: (error) {
// print("Upload Failed: ${error.message}");
// },
// );
*/
