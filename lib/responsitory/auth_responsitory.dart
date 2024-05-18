import 'package:arch_movie/data/network/BaseApiService.dart';
import 'package:arch_movie/data/network/NetworkApiService.dart';

import '../res/app_url.dart';

class AuthRepository {
  final BaseApiService _baseApiService = NetWorkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = _baseApiService.getPostApiResponse(AppUrl.loginApiEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = _baseApiService.getPostApiResponse(AppUrl.registerApiEndpoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
