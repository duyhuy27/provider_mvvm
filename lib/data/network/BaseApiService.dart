import 'dart:convert';

import 'package:arch_movie/data/shared_preferences.dart';

abstract class BaseApiService {
  int timeOutDuration = 60;
  Map<String, String> get defaultAuth => {
        if (Prefs.get<String>(PreferencesKey.token).isNotEmpty)
          'Authorization': 'Bearer ${Prefs.get<String>(PreferencesKey.token)}',
      };

  Future<HttpResponse> getGetApiResponse({
    required String url,
    Map<String, String> header = const {},
    bool bodyByte = false,
    bool debug = false,
    bool defaultAuthen = true,
    int? timeout,
  });

  Future<HttpResponse> getPostApiResponse({
    required String url,
    dynamic body = const {},
    Map<String, String> header = const {},
    bool debug = false,
    bool bodyByte = false,
    bool defaultAuthen = true,
    Encoding? encoding,
    int? timeout,
  });
}

class HttpResponse {
  int? statusCode;
  String? statusText;
  final dynamic _bodyRaw;
  final Map<String, String> header;
  dynamic get body {
    try {
      return jsonDecode(_bodyRaw);
    } catch (e) {
      return _bodyRaw;
    }
  }

  @override
  String toString() {
    const encoder = JsonEncoder.withIndent('     ');
    return encoder
        .convert({'code': statusCode, 'status': statusText, 'body': body});
  }

  HttpResponse({
    dynamic bodyRaw,
    this.statusCode,
    this.statusText,
    this.header = const {},
  }) : _bodyRaw = bodyRaw;
}

class Result<T> {
  Result({
    this.httpMessage,
    this.result,
    this.code,
    this.header = const {},
  });
  final T? result;
  final int? code;
  final Map<String, String> header;
  bool get success => result != null;
  final dynamic httpMessage;
  String get message {
    try {
      if (httpMessage is List) {
        return httpMessage.first;
      }
      if (httpMessage == 'Bad Gateway') {
        return "Something went wrong. Please try again later.";
      }
      if (success) {
        return 'OK';
      }
      return httpMessage ?? "Something went wrong. Please try again later.";
    } catch (e) {
      return httpMessage.toString();
    }
  }
}
