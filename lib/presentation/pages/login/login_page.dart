import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freesms/metrix/metrix.dart';
import 'package:freesms/presentation/pages/login/referral_screen.dart';
import 'package:freesms/presentation/pages/login/request_otp_code_state.dart';
import 'package:freesms/presentation/pages/splash/splash_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:toast/toast.dart';
import '../../../helpers/sharedprefs.dart';
import '../../../pages/policy.dart';
import '../../../pages/terms.dart';
import '../../../user/providers/userProvider.dart';
import '../../shared/utils/injection_container.dart';
import 'request_otp_code_bloc.dart';
import 'verify_otp_code_bloc.dart';
import 'verify_otp_code_state.dart';
import 'widgets/countries_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/otp_wait_progress_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _countryPhoneCodeController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _refferalNumberController = TextEditingController();
  var _code = '';
  var _enableResend = false;
  bool isChecked = true;
  bool referralStatus = false;
  late final FocusNode focusNode;
  late final TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    _countryPhoneCodeController.dispose();
    _mobileNumberController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  void _sendCode(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var _mobileNumber = _mobileNumberController.text.startsWith('0')
          ? _mobileNumberController.text.substring(1)
          : _mobileNumberController.text;
      context.read<RequestOtpCodeBloc>().requestOtpCode(
          _countryPhoneCodeController.text + _mobileNumber,
          refferalCode: _refferalNumberController.text);
    }
  }

  void _verifyCode(BuildContext context) {
    var _mobileNumber = _mobileNumberController.text.startsWith('0')
        ? _mobileNumberController.text.substring(1)
        : _mobileNumberController.text;

    context.read<VerifyOtpCodeBloc>().verifyOtpCode(
        _countryPhoneCodeController.text + _mobileNumber, int.parse(_code));
  }

  void _enableResendCallback(bool enable) {
    setState(() {
      _enableResend = enable;
    });
  }

  void _countrySelectionCallback(String countryPhoneCodeController) {
    FreeSmsMetrix.countryCode(countryPhoneCodeController);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      _countryPhoneCodeController.text = countryPhoneCodeController;
    }));
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    RequestOtpCodeBloc requestOtpCodeBloc = sl<RequestOtpCodeBloc>();
    VerifyOtpCodeBloc verifyOtpCodeBloc = sl<VerifyOtpCodeBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => requestOtpCodeBloc,
        ),
        BlocProvider(
          create: (BuildContext context) => verifyOtpCodeBloc,
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<VerifyOtpCodeBloc, VerifyOtpCodeState>(
          listenWhen: (previous, current) => current is VerifyOtpCodeSuccess,
          listener: (context, state) {
            SharedPrefs.setLoginDone(true);
            SharedPrefs.setPhoneNumber(_mobileNumberController.text);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SplashPage()),
              );
            });
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/login_bg.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0x40003FE7),
                    Color(0xA6001651),
                    Color(0xFF00103C)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
              Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Text(AppLocalizations.of(context).login),
                  titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                body: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // otp request and verification
                        Builder(builder: (context) {
                          // request otp state
                          final requestState =
                              context.watch<RequestOtpCodeBloc>().state;
                          final verifyState =
                              context.watch<VerifyOtpCodeBloc>().state;

                          // otp request successful
                          if (requestState is RequestOtpCodeSuccess ||
                              requestState is RequestOtpCodeLoading) {
                            // enter otp code and verify it
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).verifyingMobile,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  '${AppLocalizations.of(context).enterCode} ${_mobileNumberController.text}',
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                const SizedBox(height: 28.0),
                                PinFieldAutoFill(
                                    decoration: BoxLooseDecoration(
                                      strokeColorBuilder:
                                      const FixedColorBuilder(Colors.grey),
                                      bgColorBuilder:
                                      const FixedColorBuilder(Colors.white),
                                      hintText: "______",
                                    ),
                                    focusNode: focusNode,
                                    currentCode: _code,
                                    onCodeSubmitted: (code) {
                                      print('object');

                                      FocusScope.of(this.context)
                                          .requestFocus(focusNode);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
                                        setState(() {
                                          _code = code;
                                        });
                                        if (code.length == 6) {
                                          // TODO verify otp code with code
                                        }
                                      });
                                    },
                                    onCodeChanged: (code) {
                                      print('object');
                                      if (code!.length == 6) {
                                        FocusScope.of(this.context)
                                            .requestFocus(focusNode);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          setState(() {
                                            _code = code;
                                          });
                                          _verifyCode(context);
                                        });
                                        // TODO verify otp code with code
                                      }
                                    },
                                    controller: codeController,
                                    //code changed callback
                                    codeLength: 6 //code length, default 6
                                ),
                                const SizedBox(height: 32),
                                _enableResend
                                    ? Center(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty
                                          .resolveWith<Color?>(
                                              (Set<MaterialState>
                                          states) {
                                            return Colors.white;
                                          }),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _enableResend = false;
                                      });
                                      FreeSmsMetrix.resendOTPCode(
                                        phoneNumber:
                                        _mobileNumberController.text,
                                      );
                                      _sendCode(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 16.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .resend,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                                    : OtpWaitProgressBar(_enableResendCallback),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 48,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                            if (_code.length < 6) {
                                              return const Color(0xFFC5D4FF);
                                            } else {
                                              return const Color(0xFF2C66FF);
                                            }
                                          }),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => _code.length < 6
                                        ? null
                                        : _verifyCode(context),
                                    child: Builder(builder: ((context) {
                                      if (verifyState is VerifyOtpCodeLoading) {
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              'Loading',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        );
                                      } else if (verifyState
                                      is VerifyOtpCodeSuccess) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .welcome,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        );
                                      } else {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          // if error
                                          if (verifyState
                                          is VerifyOtpCodeFailure) {
                                            // reset to initial state
                                            context
                                                .read<VerifyOtpCodeBloc>()
                                                .resetState();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "خطا در دریافت کد -")));
                                          }
                                        });
                                        return Text(
                                          AppLocalizations.of(context).enter,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        );
                                      }
                                    })),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // initial state or failure state!
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // if error
                              if (requestState is RequestOtpCodeFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("خطا در دریافت کد--")));
                              }
                            });
                            // select country and input phone number to request otp code.
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).welcomeToSms,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 12.0),
                                Text(
                                  AppLocalizations.of(context)
                                      .enterMobileForLogin,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                const SizedBox(height: 32.0),
                                Column(
                                  children: [
                                    Row(
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .country,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              CountriesSelector(
                                                  _countrySelectionCallback),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)
                                                    .mobileNumber,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                controller:
                                                _mobileNumberController,
                                                keyboardType:
                                                TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .deny(RegExp(r'^0+')),
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10.0),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide.none,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                    ),
                                                    hintText: "9361234567"),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return AppLocalizations.of(
                                                        context)
                                                        .pleaseEnterMobile;
                                                  }
                                                  if (value.length < 10 ||
                                                      value.length > 11) {
                                                    return AppLocalizations.of(
                                                        context)
                                                        .pleaseEnterValid;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    // Center(
                                    //   child: InkWell(
                                    //     child: const Text("Referral number?",style: TextStyle(color: Colors.white,
                                    //     fontSize: 16)),
                                    //     onTap: (){
                                    //       setState(() {
                                    //         referralStatus=!referralStatus;
                                    //       });
                                    //     },
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 10,),
                                    // Visibility(
                                    //   visible: referralStatus,
                                    //   child: Container(
                                    //     child: TextField(
                                    //       controller: _refferalNumberController,
                                    //       maxLines: 1,
                                    //       decoration: InputDecoration(
                                    //           contentPadding:
                                    //           const EdgeInsets.symmetric(
                                    //               vertical: 5.0,
                                    //               horizontal: 5.0),
                                    //           filled: true,
                                    //           fillColor: Colors.white,
                                    //           border: OutlineInputBorder(
                                    //             borderSide: BorderSide.none,
                                    //             borderRadius:
                                    //             BorderRadius.circular(8.0),
                                    //           ),
                                    //           hintText: "Referral phoneNumber"),
                                    //     ),
                                    //     height: 40,
                                    //     padding: EdgeInsets.symmetric(horizontal: 60),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  height: 48,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                            if (states
                                                .contains(MaterialState.pressed)) {
                                              return const Color(0xFF2C66FF);
                                            } else {
                                              return const Color(0xFF2C66FF);
                                            }
                                          }),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      void sendCode() {
                                        if (isChecked) {
                                          _sendCode(context);
                                        } else {
                                          Toast.show(
                                              "you must accept privacy and policy");
                                        }
                                      }

                                      final status =
                                      await Permission.sms.status;
                                      if (status.isDenied) {
                                        final status =
                                        await Permission.sms.request();
                                        if (status.isGranted) {
                                          sendCode();
                                        }
                                      } else {
                                        sendCode();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      child: Text(
                                        AppLocalizations.of(context).sendCode,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                // const RichText('By creating your account you agree to our terms of privacy and policy',)
                              ],
                            );
                          }
                        }),
                        // empty space and privacy link text
                        // const SizedBox(height: 40),
                        MediaQuery.of(context).viewInsets.bottom > 0
                            ? const Spacer(flex: 1)
                            : const SizedBox(height: 40),
                        Row(
                          children: [
                            Checkbox(
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                    width: 1.0, color: Colors.white),
                              ),
                              activeColor: Colors.white,
                              focusColor: Colors.blue,
                              checkColor: Colors.blueAccent,
                              hoverColor: Colors.blue,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  print(isChecked);
                                });
                              },
                            ),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: AppLocalizations.of(context)
                                        .byCreatingAccount,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    children: [
                                      TextSpan(
                                          text:
                                          ' ${AppLocalizations.of(context).privacy} ',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              FreeSmsMetrix.readTerm();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const Terms()),
                                              );
                                            },
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16)),
                                      TextSpan(
                                          text:
                                          AppLocalizations.of(context).and,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      TextSpan(
                                          text:
                                          ' ${AppLocalizations.of(context).policy} ',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              FreeSmsMetrix.readPrivacyPolicy();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const Policy()),
                                              );
                                            },
                                          style: const TextStyle(
                                              color: Colors.blue, fontSize: 16))
                                    ])),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}