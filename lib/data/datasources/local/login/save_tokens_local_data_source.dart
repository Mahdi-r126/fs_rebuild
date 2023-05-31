import 'package:freesms/helpers/sharedprefs.dart';
import '../../../../models/tokens.dart';

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