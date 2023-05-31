import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freesms/helpers/string_helper.dart';
import 'package:collection/collection.dart';

typedef OnSmsTap = FutureOr<void> Function(String value);

class MessageBox extends StatefulWidget {
  const MessageBox({
    Key? key,
    required this.message,
    this.color = Colors.white,
    this.onLinkTap,
    this.onUssdTap,
    this.onTimeTap,
    this.onNumberTap,
  }) : super(key: key);

  final String message;
  final Color color;

  final OnSmsTap? onLinkTap;
  final OnSmsTap? onUssdTap;
  final OnSmsTap? onTimeTap;
  final OnSmsTap? onNumberTap;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  late final span = <InlineSpan>[];

  @override
  void initState() {
    super.initState();
    initSpan();
  }

  void initSpan() {
    final lines = LineSplitter.split(widget.message);
    final messages = lines.map((message) {
      final list = <BaseText>[];
      message.splitMapJoin(
        RegExp(
          '(${AppRegex.hmPattern})|(${AppRegex.numPattern})|'
          '(${AppRegex.linkPattern})|(${AppRegex.ussdPattern})',
          caseSensitive: false,
        ),
        onMatch: (m) {
          final text = m[0];
          if (text == null) {
            return '';
          }
          if (RegExp(AppRegex.linkPattern).hasMatch(text)) {
            list.add(BaseText(text: text, type: TextType.link));
            return '';
          } else if (RegExp(AppRegex.ussdPattern).hasMatch(text)) {
            list.add(BaseText(text: text, type: TextType.ussd));
            return '';
          } else if (RegExp(AppRegex.hmPattern).hasMatch(text)) {
            list.add(BaseText(text: text, type: TextType.time));
            return '';
          } else if (RegExp(AppRegex.numPattern).hasMatch(text)) {
            list.add(BaseText(text: text, type: TextType.number));
            return '';
          }

          return '';
        },
        onNonMatch: (text) {
          list.add(BaseText(text: text));

          return '';
        },
      );
      return list;
    });

    for (final line in messages) {
      for (final data in line) {
        span.add(
          TextSpan(
            text: data.text,
            style: TextStyle(
              decoration: data.type == TextType.normal
                  ? null
                  : TextDecoration.underline,
            ),
            recognizer:
                data.type == TextType.normal ? null : TapGestureRecognizer()
                  ?..onTap = () async {
                    switch (data.type) {
                      case TextType.link:
                        await widget.onLinkTap?.call(data.text);
                        break;
                      case TextType.ussd:
                        await widget.onUssdTap?.call(data.text);
                        break;
                      case TextType.time:
                        await widget.onTimeTap?.call(data.text);
                        break;
                      case TextType.number:
                        await widget.onNumberTap?.call(data.text);
                        break;
                      case TextType.normal:
                        break;
                    }
                  },
          ),
        );
      }
      final isLastLine = const DeepCollectionEquality().equals(messages.last, line);
      if (isLastLine) {
        continue;
      } else {
        span.add(const TextSpan(text: '\n'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 15,
          color: widget.color,
        ),
        children: span,
      ),
    );
  }
}
