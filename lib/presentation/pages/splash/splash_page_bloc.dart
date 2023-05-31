import 'package:bloc/bloc.dart';
import 'package:freesms/presentation/pages/splash/splash_page.dart';
import 'package:freesms/presentation/pages/splash/splash_page_state.dart';

import '../../../domain/usecases/splash/check_version.dart';
import '../../shared/entities/failure.dart';

class SplashPageBloc extends Cubit<SplashPageState> {
  final CheckVersion chkVersion;

  SplashPageBloc({required this.chkVersion})
      : super(SplashPageInitial());

  Future<void> checkVersion() async {
    emit(SplashPageLoading());
    try {
      String version = await chkVersion();
      if (version.isNotEmpty) {
        emit(SplashPageSuccess(version));
      } else {
        emit(const SplashPageFailure('Some thing went wrong, do you have any contacts!'));
      }
    } catch (e) {
      Failure failure = e as Failure;
      emit(SplashPageFailure(failure.message));
    }
  }
}
