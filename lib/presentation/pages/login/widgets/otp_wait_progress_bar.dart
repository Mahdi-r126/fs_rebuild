import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpWaitProgressBar extends StatefulWidget {
  final Function enableResendCallback;
  const OtpWaitProgressBar(this.enableResendCallback, {Key? key}) : super(key: key);

  @override
  State<OtpWaitProgressBar> createState() => _OtpWaitProgressBarState();
}

class _OtpWaitProgressBarState extends State<OtpWaitProgressBar> {
  late Timer _timer;
  int _totalSeconds = 60;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (timer) {
        setState(() {
          if (_totalSeconds == 0) {
            timer.cancel();
            widget.enableResendCallback(true);
          } else {
            _totalSeconds--;
          }
        });
      },
    );
  }

  String _secondsToMmSsFormat() {
    int minutes = _totalSeconds ~/ 60;
    int seconds = _totalSeconds % 60;
    return minutes.toString().padLeft(2, '0') + ':' + seconds.toString().padLeft(2, '0');
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              value: _totalSeconds / 60,
              color: Colors.blue,
              backgroundColor: const Color(0xFF303237),
              minHeight: 10,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Text(_secondsToMmSsFormat(), style: const TextStyle(color: Colors.white, fontSize: 14),),
      ],
    );
  }
}