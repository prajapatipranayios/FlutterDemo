import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Log {
  Log.displayResponse({payload, var res, String requestType = 'GET'}) {
    // res as http.Response;
    if (payload != null) {
      String logData = payload.toString();
      if (logData.length > 1000) {
        if (kDebugMode) {
          print("payload : ");
        }
        int maxLogSize = 1000;
        for (int i = 0; i <= logData.length / maxLogSize; i++) {
          int start = i * maxLogSize;
          int end = (i + 1) * maxLogSize;
          end = end > logData.length ? logData.length : end;
          if (kDebugMode) {
            print(logData.substring(start, end));
          }
        }
      } else {
        if (kDebugMode) {
          print("payload : $payload");
        }
      }
    }
    if (res != null && res is http.Response) {
//      print('headers : '+ res.headers.toString());
      if (kDebugMode) {
        print("url : ${res.request!.url}");
      }
      if (requestType.isNotEmpty) {
        if (kDebugMode) {
          print("requestType : $requestType");
        }
      }
      if (kDebugMode) {
        print("status code : ${res.statusCode}");
      }
      if (res.body.isNotEmpty) {
        String logData = res.body.toString();
        if (logData.length > 1000) {
          if (kDebugMode) {
            print("response : ");
          }
          int maxLogSize = 1000;
          for (int i = 0; i <= logData.length / maxLogSize; i++) {
            int start = i * maxLogSize;
            int end = (i + 1) * maxLogSize;
            end = end > logData.length ? logData.length : end;
            if (kDebugMode) {
              print(logData.substring(start, end));
            }
          }
        } else {
          if (kDebugMode) {
            print("response : ${res.body}");
          }
        }
      }
    } else {
      if (kDebugMode) {
        print("Log displayResponse is : $res");
      }
    }
  }
}
