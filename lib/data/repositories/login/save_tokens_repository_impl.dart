import 'package:freesms/models/tokens.dart';
import '../../../domain/repositories/login/save_tokens_repository.dart';
import '../../datasources/local/login/save_tokens_local_data_source.dart';

class SaveTokensRepositoryImpl implements SaveTokensRepository {

  final SaveTokensLocalDataSource saveTokensLocalDataSource;

  SaveTokensRepositoryImpl({required this.saveTokensLocalDataSource});

  @override
  void saveTokens(Tokens tokens) {
    void saveResult = saveTokensLocalDataSource.saveTokens(tokens);
    return saveResult;
  }
}