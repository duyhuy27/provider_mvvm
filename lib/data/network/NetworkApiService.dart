import 'dart:convert';
import 'dart:io';

import 'package:arch_movie/data/network/BaseApiService.dart';
import 'package:arch_movie/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../res/app_url.dart';

class NetWorkApiService extends BaseApiService {
  @override
  Future<HttpResponse> getGetApiResponse({
    required String url,
    Map<String, String> header = const {},
    bool bodyByte = false,
    bool debug = false,
    bool defaultAuthen = true,
    int? timeout,
  }) async {
    final headers = <String, String>{
      'content-type': ContentType.Application_Json
    };

    if (defaultAuthen) {
      defaultAuth.forEach((key, value) {
        headers[key] = value;
      });
    }

    header.forEach((key, value) {
      headers[key] = value;
    });

    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers).timeout(
            Duration(seconds: timeout ?? timeOutDuration),
            onTimeout: () => throw Exception('Connection Time Out'),
          );

      if (debug) {
        Utils.printJson({
          'uri': uri.toString(),
          'header': headers,
          'status_code': response.statusCode,
          'status_text': response.reasonPhrase,
          'res': bodyByte
              ? null
              : () {
                  try {
                    return jsonDecode(response.body);
                  } catch (e) {
                    return response.body;
                  }
                }(),
        });
      }

      return HttpResponse(
        bodyRaw: bodyByte ? response.bodyBytes : response.body,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
        header: response.headers,
      );
    } on SocketException {
      return HttpResponse(
        statusCode: 0,
        statusText: 'No Internet connection',
      );
    } catch (e) {
      return HttpResponse(
        statusCode: 0,
        statusText: e.toString(),
      );
    }
  }

  @override
  Future<HttpResponse> getPostApiResponse({
    required String url,
    dynamic body = const {},
    Map<String, String> header = const {},
    bool debug = false,
    bool bodyByte = false,
    bool defaultAuthen = true,
    Encoding? encoding,
    int? timeout,
  }) async {
    final headers = <String, String>{
      'content-type': ContentType.Application_Json
    };

    if (defaultAuthen) {
      defaultAuth.forEach((key, value) {
        headers[key] = value;
      });
    }

    header.forEach((key, value) {
      headers[key] = value;
    });

    try {
      final uri = Uri.parse(url);
      final response = await http
          .post(
            uri,
            headers: headers,
            body: jsonEncode(body),
            encoding: encoding,
          )
          .timeout(
            Duration(seconds: timeout ?? timeOutDuration),
            onTimeout: () => throw Exception('Connection Time Out'),
          );

      if (debug) {
        Utils.printJson({
          'uri': uri.toString(),
          'header': headers,
          'body': body,
          'status_code': response.statusCode,
          'status_text': response.reasonPhrase,
          'res': bodyByte
              ? null
              : () {
                  try {
                    return jsonDecode(response.body);
                  } catch (e) {
                    return response.body;
                  }
                }(),
        });
      }

      return HttpResponse(
        bodyRaw: bodyByte ? response.bodyBytes : response.body,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
        header: response.headers,
      );
    } on SocketException {
      return HttpResponse(
        statusCode: 0,
        statusText: 'No Internet connection',
      );
    } catch (e) {
      return HttpResponse(
        statusCode: 0,
        statusText: e.toString(),
      );
    }
  }

  // dynamic returnResponse(http.Response response) {
  //   switch (response.statusCode) {
  //     case 200:
  //       dynamic responseJson = jsonDecode(response.body);
  //       return responseJson;
  //     case 400:
  //       throw BadRequestException(response.body.toString());
  //     case 401:
  //     case 403:
  //       throw UnauthorisedException(response.body.toString());
  //     case 500:
  //     default:
  //       throw FetchDataException(
  //           'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  //   }
  // }
}
