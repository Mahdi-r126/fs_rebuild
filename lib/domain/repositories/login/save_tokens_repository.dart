import 'package:freesms/models/tokens.dart';

abstract class SaveTokensRepository {
  void saveTokens(Tokens tokens);
}