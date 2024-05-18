import 'package:arch_movie/data/network/BaseApiService.dart';
import 'package:arch_movie/data/network/NetworkApiService.dart';
import 'package:arch_movie/model/user_model.dart';
import 'package:arch_movie/responsitory/base_repository.dart';
import 'package:flutter/cupertino.dart';

import '../res/app_url.dart';

class AuthRepository extends BaseRepository {
  final BaseApiService _baseApiService = NetWorkApiService();

  Future<Result<String>> loginApi({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _baseApiService.getPostApiResponse(
        url: AppUrl.loginApiEndpoint,
        body: {
          'email': email,
          'password': password,
        },
        // debug: true,
      );
      if (httpValidate(context, res)) {
        return Result(result: res.body['token'] ?? '');
      } else {
        return Result(httpMessage: res.body['error'] ?? res.statusText);
      }
    } catch (e) {
      return Result();
    }
  }

  Future<Result<String>> registerApi({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _baseApiService.getPostApiResponse(
        url: AppUrl.registerApiEndpoint,
        body: {
          'email': email,
          'password': password,
        },
        // debug: true,
      );
      if (httpValidate(context, res)) {
        return Result(result: res.body['token'] ?? '');
      } else {
        return Result(httpMessage: res.body['error'] ?? res.statusText);
      }
    } catch (e) {
      return Result();
    }
  }

  Future<Result<UserModel>> getUserData({
    required BuildContext context,
    required int id,
  }) async {
    try {
      final res = await _baseApiService.getGetApiResponse(
        url: AppUrl.getUserApiEndpoint(id),
        // debug: true,
      );
      if (httpValidate(context, res)) {
        return Result(result: UserModel.fromJson(res.body['data']));
      } else {
        return Result(httpMessage: res.body['error'] ?? res.statusText);
      }
    } catch (e) {
      return Result();
    }
  }
}
