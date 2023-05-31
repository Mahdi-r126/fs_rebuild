import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freesms/helpers/sharedprefs.dart';
import 'package:freesms/metrix/metrix.dart';
import 'package:freesms/presentation/pages/login/cubit/referral_cubit.dart';
import 'package:freesms/presentation/pages/splash/splash_page.dart';
import 'package:freesms/presentation/shared/utils/injection_container.dart';
import 'package:freesms/user/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferralCubit(api: sl()),
      child: _ReferralScreen(),
    );
  }
}

class _ReferralScreen extends StatefulWidget {
  @override
  State<_ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<_ReferralScreen> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReferralCubit, ReferralState>(
          listenWhen: (previous, current) =>
              current.sendingStatus == ReferralSendingStatus.success,
          listener: (context, state) {
            final phoneNumber=SharedPrefs.getPhoneNumber();
            FreeSmsMetrix.invited(_codeController.text, false,'$phoneNumber');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashPage(),
              ),
            );
          },
        ),
        BlocListener<ReferralCubit, ReferralState>(
          listenWhen: (previous, current) =>
              current.sendingStatus == ReferralSendingStatus.failure,
          listener: (context, state) {
            Toast.show('invalid referral code.',
                backgroundColor: Colors.red,
                textStyle: const TextStyle(
                  color: Colors.white,
                ));
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Invite your friends",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Please enter your referral phone number",
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset("assets/images/referral.png"),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Material(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                            child: BlocSelector<ReferralCubit, ReferralState,
                                    bool>(
                                selector: (state) =>
                                    state.checkingStatus ==
                                    ReferralCheckingStatus.initial,
                                builder: (context, isInitial) {
                                  return TextFormField(
                                    // enabled: isInitial,
                                    controller: _codeController,
                                    // maxLength: 11,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 11) {
                                        context
                                            .read<ReferralCubit>()
                                            .check(value);
                                        return;
                                      }
                                      final bool isChecked = context
                                              .read<ReferralCubit>()
                                              .state
                                              .checkingStatus !=
                                          ReferralCheckingStatus.initial;
                                      if (isChecked && value.length < 11) {
                                        context
                                            .read<ReferralCubit>()
                                            .resetChecking();
                                      }
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      hintText: '09121234567',

                                      // prefix: isInitial
                                      //     ? null
                                      //     : IconButton(
                                      //         onPressed: () {
                                      //           context.read<ReferralCubit>().resetChecking();
                                      //           _codeController.clear();
                                      //
                                      //         },
                                      //         icon: Icon(
                                      //           Icons.clear,
                                      //           color: Colors.grey.shade700,
                                      //         )),
                                      suffix: BlocSelector<
                                          ReferralCubit,
                                          ReferralState,
                                          ReferralCheckingStatus>(
                                        selector: (state) =>
                                            state.checkingStatus,
                                        builder: (context, status) {
                                          switch (status) {
                                            case ReferralCheckingStatus.initial:
                                              return const SizedBox.shrink();
                                            case ReferralCheckingStatus
                                                .inProgress:
                                              return const SizedBox.square(
                                                dimension: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.blue,
                                                ),
                                              );
                                            case ReferralCheckingStatus.failure:
                                              return const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              );
                                            case ReferralCheckingStatus.success:
                                              return const Icon(
                                                Icons.check_box,
                                                color: Colors.green,
                                              );
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:
                              BlocSelector<ReferralCubit, ReferralState, bool>(
                            selector: (state) =>
                                state.checkingStatus ==
                                ReferralCheckingStatus.success,
                            builder: (context, isValid) {
                              return BlocSelector<ReferralCubit, ReferralState,
                                  bool>(
                                selector: (state) =>
                                    state.sendingStatus ==
                                    ReferralCheckingStatus.inProgress,
                                builder: (context, isLoading) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.black45,
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    onPressed: !isValid || isLoading
                                        ? null
                                        : () {
                                            context
                                                .read<ReferralCubit>()
                                                .send(_codeController.text);
                                          },
                                    child: Center(
                                      child: isLoading
                                          ? const SizedBox.square(
                                              dimension: 25,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const Text(
                                              "Confirm",
                                            ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    child: const Text("Skip", style: TextStyle(fontSize: 17)),
                    onTap: () {
                      final phoneNumber=SharedPrefs.getPhoneNumber();
                      FreeSmsMetrix.invited('', true,'$phoneNumber');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
