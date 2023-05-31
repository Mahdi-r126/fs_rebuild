import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freesms/apis/apis.dart';
import 'package:freesms/user/models/userModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../helpers/constants.dart';
import '../../helpers/sharedprefs.dart';
import '../../models/responseModel.dart';

class UserProvider extends ChangeNotifier {
  late UserModels userModel;
  late ResponseModel state;
  List<String> getRoles() {
    getUserData();
    return roles;
  }

  List<String> roles = [];

  getUserData() async {
    state = ResponseModel.loading("is loading");
    try {
      Dio dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: 100000,
        receiveTimeout: 100000,
      ));

      String accessToken = SharedPrefs.getAccessToken();
      String refreshToken = SharedPrefs.getRefreshToken();

      dio.interceptors.addAll([
        InterceptorsWrapper(onRequest: (options, handler) async {
          options.headers['authorization'] = 'bearer ' + accessToken;
          options.headers['refresh-token'] = refreshToken;
          return handler.next(options);
        }, onError: (DioError error, handler) async {
          return handler.next(error);
        }),
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90)
      ]);

      final response = await dio.get("/user");
      print(response);
      if (response.statusCode == 200) {
        userModel =
            UserModels.fromJson(response.data['data']['result']);
        roles = userModel.roles!;
        if (roles.contains("admin")) {
          SharedPrefs.setAdmin(true);
        } else {
          SharedPrefs.setAdmin(false);
        }
        state = ResponseModel.completed(userModel);
        notifyListeners();
      } else {
        state = ResponseModel.error("something wrong...");
      }
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
    }
  }
}
