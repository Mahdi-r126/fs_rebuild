import '../../repositories/splash/check_version_repository.dart';

class CheckVersion {
final CheckVersionRepository checkVersionRepository;

CheckVersion({required this.checkVersionRepository});

Future<String> call() async {
  return await checkVersionRepository.checkVersion();
}

}