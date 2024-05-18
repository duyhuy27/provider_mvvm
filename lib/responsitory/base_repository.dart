import 'package:flutter/material.dart';

import '../data/network/BaseApiService.dart';
import '../utils/application.dart';

abstract class BaseRepository {
  bool httpValidate(BuildContext context, HttpResponse res,
      {bool logoutOnAuthFailed = true}) {
    final statusCode = (res.statusCode ?? 0);
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    }
    if (statusCode == 401 && logoutOnAuthFailed) {
      onAuthenFailed(context);
    }

    return false;
  }

  Future onAuthenFailed(BuildContext context) async {
    await Application.logout(context);
  }
}
