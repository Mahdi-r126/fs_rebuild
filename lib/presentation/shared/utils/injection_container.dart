import 'package:freesms/data/datasources/local/login/save_tokens_local_data_source.dart';
import 'package:freesms/data/datasources/remote/login/request_otp_code_remote_data_source.dart';
import 'package:freesms/data/datasources/remote/login/verify_otp_code_remote_data_source.dart';
import 'package:freesms/data/repositories/audit_ads/get_ads_for_audit_repositoey_impl.dart';
import 'package:freesms/data/repositories/login/verify_otp_code_repository_impl.dart';
import 'package:freesms/domain/repositories/login/request_otp_code_repository.dart';
import 'package:freesms/domain/repositories/login/verify_otp_code_repository.dart';
import 'package:freesms/presentation/pages/login/verify_otp_code_bloc.dart';
import 'package:freesms/presentation/shared/utils/send_sms_repository_impl.dart';
import 'package:get_it/get_it.dart';
import '../../../apis/apis.dart';
import '../../../data/datasources/local/contacts_read/read_contacts_local_data_source.dart';
import '../../../data/datasources/remote/audit_ads/get_ads_for_audit_remote_data_source.dart';
import '../../../data/datasources/remote/sponsor_ads/get_sponsor_ads_remote_data_source.dart';
import '../../../data/repositories/contacts_read/read_contacts_repository_impl.dart';
import '../../../data/repositories/login/request_otp_code_repository_impl.dart';
import '../../../data/repositories/login/save_tokens_repository_impl.dart';
import '../../../data/repositories/sponsor_ads/get_sponor_ads_repositoey_impl.dart';
import '../../../domain/repositories/audit_ads/get_ads_for_audit_repository.dart';
import '../../../domain/repositories/contacts_read/read_contacts_repository.dart';
import '../../../domain/repositories/login/save_tokens_repository.dart';
import '../../../domain/repositories/login/send_sms_repository.dart';
import '../../../domain/repositories/sponsor_ads/get_sponsor_ads_repository.dart';
import '../../../domain/usecases/audit_ads/get_ads_for_audit.dart';
import '../../../domain/usecases/contacts_read/read_contacts.dart';
import '../../../domain/usecases/login/request_otp_code.dart';
import '../../../domain/usecases/login/save_tokens.dart';
import '../../../domain/usecases/login/send_sms.dart';
import '../../../domain/usecases/login/verify_otp_code.dart';
import '../../../domain/usecases/splash/check_version.dart';
import '../../../domain/usecases/sponsor_ads/get_sponsor_ads.dart';
import '../../pages/audit_ads/audit_ads_bloc.dart';
import '../../pages/home/contacts_view/read_contacts_bloc.dart';
import '../../pages/login/request_otp_code_bloc.dart';
import '../../pages/splash/splash_page_bloc.dart';
import '../../pages/sponsor_ads/sponsor_ads_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  // login
  sl.registerFactory(() => RequestOtpCodeBloc(sendSms: sl(), reqOtpCode: sl()));
  sl.registerFactory(() => VerifyOtpCodeBloc(saveTokens: sl(), verOtpCode: sl()));

  // read contacts
  sl.registerFactory(() => ReadContactsBloc(readContacts: sl()));
  
  // splash screen
  sl.registerFactory(() => SplashPageBloc(chkVersion: sl()));

  // audit ads
  sl.registerFactory(() => AuditAdsBloc(getAdsAudit: sl()));

  // sponsor ads
  sl.registerFactory(() => SponsorAdsBloc(getSponsorAds: sl()));
  

  // Use cases
  // login
  sl.registerLazySingleton(() => RequestOtpCode(requestOtpCodeRepository: sl()));
  sl.registerLazySingleton(() => SendSms(sendSmsRepository: sl()));
  sl.registerLazySingleton(() => VerifyOtpCode(verifyOtpCodeRepository: sl()));
  sl.registerLazySingleton(() => SaveTokens(saveTokensRepository: sl()));

  // read contacts
  sl.registerLazySingleton(() => ReadContacts(readContactsRepository: sl()));

  // splash screen
  sl.registerLazySingleton(() => CheckVersion(checkVersionRepository: sl()));

  // audit ads
  sl.registerLazySingleton(() => GetAdsForAudit(getAdsForAuditRepository: sl()));

  // sponsor ads
  sl.registerLazySingleton(() => GetSponsorAds(getSponsorAdsRepository: sl()));


  // Repositories
  // login
  sl.registerLazySingleton<RequestOtpCodeRepository>(() => RequestOtpCodeRepositoryImpl(requestOtpCodeRemoteDataSource: sl()));
  sl.registerLazySingleton<SendSmsRepository>(() => SendSmsRepositoryImpl());
  sl.registerLazySingleton<VerifyOtpCodeRepository>(() => VerifyOtpCodeRepositoryImpl(verifyOtpCodeRemoteDataSource: sl()));
  sl.registerLazySingleton<SaveTokensRepository>(() => SaveTokensRepositoryImpl(saveTokensLocalDataSource: sl()));

  //read contacts
  sl.registerLazySingleton<ReadContactsRepository>(() => ReadContactsRepositoryImpl(readContactsLocalDataSource: sl()));

  //splash screen
  // sl.registerLazySingleton<CheckVersionRepository>(() => CheckVersionRepositoryImpl(checkVersionRemoteDataSource: sl()));

  // audit ads
  sl.registerLazySingleton<GetAdsForAuditRepository>(() => GetAdsForAuditRepositoryImpl(getAdsForAuditRemoteDataSource: sl()));

  // sponsor ads
  sl.registerLazySingleton<GetSponsorAdsRepository>(() => GetSponsorAdsRepositoryImpl(getSponsorAdsRemoteDataSource: sl()));


  // Data Sources
  // login
  sl.registerLazySingleton<RequestOtpCodeRemoteDataSource>(() => RequestOtpCodeRemoteDataSourceImpl(api: sl()));
  sl.registerLazySingleton<VerifyOtpCodeRemoteDataSource>(() => VerifyOtpCodeRemoteDataSourceImpl(api: sl()));
  sl.registerLazySingleton<SaveTokensLocalDataSource>(() => SaveTokensLocalDataSourceImpl());

  // read contacts
  sl.registerLazySingleton<ReadContactsLocalDataSource>(() => ReadContactsLocalDataSourceImpl());

  //splash screen
  // sl.registerLazySingleton<CheckVersionRemoteDataSource>(() => CheckVersionRemoteDataSourceImpl(api: sl()));

  // audit ads
  sl.registerLazySingleton<GetAdsForAuditRemoteDataSource>(() => GetAdsForAuditRemoteDataSourceImpl(api: sl()));

  // sponsor ads
  sl.registerLazySingleton<GetSponsorAdsRemoteDataSource>(() => GetSponsorAdsRemoteDataSourceImpl(api: sl()));

  //! Core

  //! External

  sl.registerLazySingleton(() => Apis());
}