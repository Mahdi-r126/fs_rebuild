import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:freesms/helpers/constants.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/models/organizations.dart';
import 'package:freesms/models/sponsor_ad.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../data/models/ads_list_model.dart';
import '../data/models/audit_ads_model.dart';
import '../data/models/user_model.dart';
import '../domain/entities/user.dart';
import '../helpers/path_provider.dart';
import '../main.dart';
import '../models/ad.dart';
import '../models/admin_login.dart';
import '../models/ads_list.dart';
import '../models/categories.dart';
import '../models/folders.dart';
import '../models/organization_ads.dart';
import '../models/themes.dart';
import '../models/tokens.dart';
import '../models/users.dart';
import '../models/wallet.dart';
import '../presentation/shared/entities/failure.dart';

class Apis {
  var cacheOptions;
  static Dio dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: 100000,
    receiveTimeout: 100000,
  ));

  String accessToken = SharedPrefs.getAccessToken();
  String refreshToken = SharedPrefs.getRefreshToken();
  String organizationAccessToken = SharedPrefs.getOrganizationAccessToken();
  String organizationRefreshToken = SharedPrefs.getOrganizationRefreshToken();
  String adminAccessToken = SharedPrefs.getAdminAccessToken();
  String adminRefreshToken = SharedPrefs.getAdminRefreshToken();

  // final SnackBar snackBar = const SnackBar(
  //     content: Text('Network error, please check your internet connection'));

  Apis() {
    dio.interceptors.addAll([
      InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers['authorization'] = 'bearer ' + accessToken;
        options.headers['refresh-token'] = refreshToken;
        return handler.next(options);
      }, onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401) {
          //GO TO ADMIN LOGIN
          navKey.currentState?.pushNamed('login');

          // if (refreshToken.isNotEmpty) {
          //   await refreshingToken();
          //   return handler.resolve(await _retry(error.requestOptions));
          // } else {
          //   // refresh token is not exist or is empty
          //   SharedPrefs.setAccessToken('');
          //   //todo go to login
          // }
        }
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
    cacheOptions = CacheOptions(
      store: HiveCacheStore(AppPathProvider.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403, 500],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 1),
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<void> refreshingToken() async {
    //TODO get new access token by passing refresh to server and then save access in box
    try {
      final response = await dio.get('refresh/token');
      if (response.statusCode! < 400) {
        accessToken = response.data['data']['access-token'];
        SharedPrefs.setAccessToken(accessToken);
      } else {
        SharedPrefs.setAccessToken('');
        SharedPrefs.setRefreshToken('');
        //todo go to login
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      SharedPrefs.setAccessToken('');
      SharedPrefs.setRefreshToken('');
      //todo go to login
    }
  }

  Future<String> checkVersion() async {
    try {
      Response response = await dio.get('static/lts');
      return response.data['data']['result']['version'];
    } on DioError catch (e) {
      if (e.response != null) {
        return "null";
      } else {
        return "null";
      }
    }
  }

  // 1
  Future<Either<Failure, int>> requestOtpCode(UserModel user) async {
    try {
      Response response = await dio.post('user/signup', data: user);
      return Right(response.data['data']['result']['otpCode']);
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(Failure(e.response!.data['data']['message']));
      } else {
        return Left(Failure(e.message));
      }
    }
  }

  Future<Either<Failure, Tokens>> verifyOtpCode(UserModel user) async {
    try {
      Response response = await dio.post('user/signup', data: user);
      return Right(Tokens.fromJson(response.data['data']['result']));
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(Failure(e.response!.data['data']['message']));
      } else {
        return Left(Failure(e.message));
      }
    }
  }

  Future<Either<Failure, AuditAdsModel>> getAdsForAudition(
      int limit, int page) async {
    try {
      Response response = await dio.get('admin/ads',
          queryParameters: {"limit": limit.toString(), "page": page.toString()},
          options: Options(headers: {
            'access-token': adminAccessToken,
            'refresh-token': adminRefreshToken
          }));
      return Right(AuditAdsModel.fromJson(response.data['data']['result']));
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(Failure(e.response!.data['data']['message']));
      } else {
        return Left(Failure(e.message));
      }
    }
  }

  Future<Either<Failure, AdsListModel>> getSponsorAds() async {
    //TODO add pagination and create AdsList entity
    try {
      Response response = await dio.get('ads');
      return Right(AdsListModel.fromJson(response.data['data']['result']));
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(Failure(e.response!.data['data']['message']));
      } else {
        return Left(Failure(e.message));
      }
    }
  }

  Future<List<dynamic>> login(User user) async {
    try {
      Response response = await dio.post('login', data: user);
      return [Tokens.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> signup(User user) async {
    try {
      Response response = await dio.post('user', data: user);
      return [Tokens.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> getCategories() async {
    try {
      Response response = await dio.get('static/categories');
      return [Categories.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> getUsersCount() async {
    try {
      Response response = await dio.get('admin/users');
      return [Users.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> getThemes(String categoryId) async {
    try {
      final params = <String, dynamic>{'categoryId': categoryId};
      Response response = await dio
          .get('static/themes?categoryId=99b01b2d-95c0-43b5-89c0-66e5abb369ea');
      print(response);
      return [Themes.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<void> selectAdsTheme(String categoryId, String themeId) async {
    try {
      await dio.put('user', data: {categoryId: categoryId, themeId: themeId});
    } on DioError catch (e) {
      throw e.message;
    }
  }

// Future<List<dynamic>> getAds() async {
//
//   try {
//     Response response = await dio.get('ads/random', options: Options(headers: {'access-token' : accessToken, 'refresh-token' : refreshToken}));
//     return [Ad.fromJson(response.data['data']['result']['ad']), null];
//   } on DioError catch (e) {
//     return [null ,e.response!.data['data']['message']];
//   }
// }

  Future<List<dynamic>> getGroupAds() async {
    try {
      Response response = await dio.get('ads/list?limit=15&page1');
      return [AdsList.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> getOrganizationAds() async {
    try {
      Response response = await dio.get('organizations/ads',
          options: Options(headers: {
            'access-token': organizationAccessToken,
            'refresh-token': organizationRefreshToken
          }));
      return [OrganizationAds.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> createAd(SponsorAd sponsorAd) async {
    try {
      Response response = await dio.post('ads', data: sponsorAd);
      return [Ad.fromJson(response.data['data']['result']['ad']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> updateWallet(
      String sender, String receiver, String purpose, String? adId) async {
    final Map<String, dynamic> data;
    try {
      if (purpose == Constants.SHARE_TO_FRIEND) {
        data = <String, dynamic>{
          'sender': sender,
          'receiver': receiver,
          "purpose": purpose,
        };
      } else {
        data = <String, dynamic>{
          'sender': sender,
          'receiver': receiver,
          "purpose": purpose,
          'adId': adId,
        };
      }
      Response response = await dio.post('message', data: data);
      return [response.data['data']['message'], null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

//TODO تعداد پیامک های فرستاده شده رو هم برگردونه
  Future<List<dynamic>> getWalletData() async {
    try {
      Response response = await dio.get('user');
      return [Wallet.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> withdraw(
      String bankCardNumber, int withdrawalAmount) async {
    try {
      final data = <String, dynamic>{
        'bankCardNumber': bankCardNumber,
        'withdrawalAmount': withdrawalAmount,
      };
      Response response = await dio.post('withdrawals', data: data);
      return [response.data['data']['message'], null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> organizationLogin(
      String username, String password) async {
    try {
      final data = <String, dynamic>{
        'username': username,
        'password': password,
      };
      Response response = await dio.post('organizations/login', data: data);
      return [Organizations.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> adminLogin(String username, String password) async {
    try {
      final data = <String, dynamic>{
        'username': username,
        'password': password,
      };

      Response response = await dio.post('admin/login', data: data);

      return [AdminLogin.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> updateConfirmList(List<String> confirmedAdsId) async {
    try {
      final data = <String, dynamic>{'confirmedAdsId': confirmedAdsId};
      Response response = await dio.put('organizations',
          options: Options(headers: {
            'access-token': organizationAccessToken,
            'refresh-token': organizationRefreshToken
          }),
          data: data);
      return [response.data['data']['result'], null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<dynamic>> auditAds(String? adId, String status) async {
    try {
      final data = <String, dynamic>{'status': status};
      Response response = await dio.put('admin/ads/$adId', data: data);
      return [response.data['data']['result'], null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [null, e.response!.data['data']['message']];
      } else {
        return [null, e.message];
      }
    }
  }

// TODO بعدا درستش کن با روت واقعی
  Future<AdsList?> querySponsorAds(searchTerm) async {
    try {
      Response response = await dio.get(Constants.path);
      return AdsList.fromJson(response.data['data']);
    } on DioError {
      return null;
    }
  }

  Future<List<dynamic>> getAllAdsByPagination() async {
    try {
      Response response = await dio.get('ads');
      return [AdsList.fromJson(response.data['data']['result']), null];
    } on DioError catch (e) {
      if (e.response != null) {
        return [
          null,
          e.response!.data['data']['message'],
          e.response!.statusCode
        ];
      } else {
        return [null, e.message];
      }
    }
  }

  Future<List<Folders>> getAllFolders() async {
    try {
      Response response = await dio.get('folder?limit=5&page1');
      final folders = List<Folders>.from(
        (response.data['data']['result']['folders'] as List<dynamic>)
            .map((json) => Folders.fromJson(json)),
      );
      return folders;
    } on DioError catch (e) {
      print('Error occurred: ${e.message}');
      rethrow;
    }
  }

  Future<String> createFolder(Folders folders) async {
    try {
      final data = <String, dynamic>{
        'title': folders.title,
        'description': folders.description,
        'icon': "",
        'numbers': folders.numbers,
      };
      Response response = await dio.post('folder', data: data);
      if (response.statusCode.toString().startsWith("2")) {
        print("folder create successfully");
        return response.data['data']['message'];
      } else {
        print("error");
        return response.data['data']['message'];
      }
    } catch (e) {
      print("error:" + e.toString());
      return "error";
    }
  }

  Future<String> reportSpamNumber(String number) async {
    final data = {
      "number": number,
    };
    try {
      Response response = await dio.post('report/spam', data: data);
      if (response.statusCode.toString().startsWith("2")) {
        print(response.data['data']['message']);
        return response.data['data']['message'];
      } else {
        print("error");
        return response.data['data']['message'];
      }
    } catch (e) {
      print("error:" + e.toString());
      return "report spam failed";
    }
  }

  Future<bool> reportCashOut(String amount,String cardNumber) async {
    String phoneNumber=SharedPrefs.getPhoneNumber();
    final data = {
      "message": "from $phoneNumber cash out $amount to $cardNumber",
      "ticketCategory":"wallet cash out"
    };
    try {
      Response response = await dio.post('report/ticket', data: data);
      if (response.statusCode.toString().startsWith("2")) {
        print(response.data['data']['message']);
        return true;
      } else {
        print("error");
        return false;
      }
    } catch (e) {
      print("error:" + e.toString());
      return false;
    }
  }

  Future<bool> checkReferralCode({required String code}) async {
    try {
      final res = await dio.get('user/referral/{code}?code=$code');

      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendReferralCode({required String code}) async {
    try {
      final res = await dio.post('user/referral/{code}?code=$code');

      if (res.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
