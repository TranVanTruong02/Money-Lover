import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/model/user_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

final splashVM = Get.put(SplashViewModel());

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);

typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  static Future<void> post(Map<String, dynamic> parameter, String path,
      {bool isToken = false,
      bool login = false,
      ResSuccess? withSuccess,
      ResFailure? failure}) async {
    try {
      // Nếu nhưa chưa vượt thời hạn mã token
      if (login == false) {
        // Nếu như thời gian hiện tại vượt qua hạn token
        if (DateTime.now().toUtc().isAfter(
            DateTime.parse(splashVM.userModel.value.accessTokenExpiration!)
                .toUtc())) {
          // Nếu token đã hết hạn
          await http.post(
            Uri.parse(SVKey.mainUrl + SVKey.baseUrl + SVKey.svRefresh),
            body: {
              "refresh_token": splashVM.userModel.value.refreshToken,
            },
          ).then((value) {
            if (kDebugMode) {
              // Nếu lỗi
              print(value.body);
            }
            var resObj = json.decode(value.body) as Map<String, dynamic>? ?? {};
            if (resObj[KKey.status] == 1) {
              splashVM.userModel.value = UserModel();
              var payload = resObj[KKey.payload] as Map? ?? {};

              Globs.udSet(payload, Globs.userPayload);

              // Thực hiện tiếp
              service(parameter, path, isToken, withSuccess, failure);
            }
          });
        } else {
          service(parameter, path, isToken, withSuccess, failure);
        }
      } else {
        service(parameter, path, isToken, withSuccess, failure);
      }
    } catch (err) {
      if (failure != null) failure(err.toString());
    }
  }
}

void service(Map<String, dynamic> parameter, String path, bool isToken,
    ResSuccess? withSuccess, ResFailure? failure) {
  // Đặt tiêu đề mặc định với Content-Type
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  if (isToken) {
    var token = Get.find<SplashViewModel>().userModel.value.accessToken;
    headers["Authorization"] = token != null ? "Bearer $token" : "";
  }
  // Sử dụng gói http để gửi yêu cầu POST với các tham số và tiêu đề được cung cấp
  http.post(Uri.parse(path), body: parameter, headers: headers).then((value) {
    if (kDebugMode) {
      // Nếu lỗi
      print(value.body);
    }
    try {
      // Giải mã
      var jsonObj = json.decode(value.body) as Map<String, dynamic>? ?? {};

      if (withSuccess != null) withSuccess(jsonObj);
    } catch (err) {
      if (failure != null) failure(err.toString());
    }
    // Nếu yêu cầu post thất bại
  }).catchError((e) {
    if (failure != null) failure(e.toString());
  });
}
