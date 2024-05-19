import 'package:arch_movie/data/network/BaseApiService.dart';
import 'package:arch_movie/data/network/NetworkApiService.dart';
import 'package:arch_movie/res/app_url.dart';

class UserRepository {
  BaseApiService _baseApiService = NetWorkApiService();

  Future<dynamic> fetchListUserApi() async {
    try {
      dynamic response = _baseApiService.getGetApiResponse(AppUrl.listUserApiEndpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
