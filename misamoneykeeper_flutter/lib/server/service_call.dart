import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);

typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {

  static void post(Map<String, dynamic> parameter, String path,
      {bool isToken = false, ResSuccess? withSuccess, ResFailure? failure}) {
    Future(() {
      try {
        // Đặt tiêu đề mặc định với Content-Type
        var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

        // if (isToken) {
        //   var token = Get.find<SplashViewModel>().userModel.value.uAuthToken;
        //   headers["access_token"] = token ?? "";
        // }

        // Sử dụng gói http để gửi yêu cầu POST với các tham số và tiêu đề được cung cấp
        http
            .post(Uri.parse(path), body: parameter, headers: headers) 
            .then((value) {
          if (kDebugMode) {
            // Nếu lỗi
            print(value.body);
          }
          try {
            // Giải mã
            var jsonObj =
                json.decode(value.body) as Map<String, dynamic>? ?? {};

            if (withSuccess != null) withSuccess(jsonObj);
          } catch (err) {
            if (failure != null) failure(err.toString());
          }
          // Nếu yêu cầu post thất bại
        }).catchError((e) {
          if (failure != null) failure(e.toString());
        });

      } catch (err) {
        if (failure != null) failure(err.toString());
      }
    });
  }
}
