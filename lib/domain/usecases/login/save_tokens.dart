import '../../../models/tokens.dart';
import '../../repositories/login/save_tokens_repository.dart';

class SaveTokens {
  final SaveTokensRepository saveTokensRepository;

  SaveTokens({required this.saveTokensRepository});

   void call(Tokens tokens) {
     saveTokensRepository.saveTokens(tokens);
  }

}