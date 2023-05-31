import 'package:dartz/dartz.dart';
import 'package:freesms/apis/apis.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/presentation/shared/entities/failure.dart';
import '../../../../models/tokens.dart';
import '../../../models/user_model.dart';

class SaveTokensLocalDataSourceImpl implements SaveTokensLocalDataSource {

  SaveTokensLocalDataSourceImpl();

  @override
  void saveTokens(Tokens tokens) {
    print('jfdjfdjs');
    SharedPrefs.setAccessToken(tokens.accessToken);
    SharedPrefs.setRefreshToken(tokens.refreshToken);
  }
}

abstract class SaveTokensLocalDataSource {
   void saveTokens(Tokens tokens);
}