import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as aa;

enum TextType {
  normal,
  link,
  number,
  ussd,
  time,
}

class BaseText with EquatableMixin {
  const BaseText({
    required this.text,
    this.type = TextType.normal,
  });

  final String text;
  final TextType type;

  @override
  List<Object?> get props => [text, type];
}

class AppRegex {
  const AppRegex();
  static const linkPattern =
      r'((https?:\/\/)?(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|(https?:\/\/)?(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';

  static const hmPattern =
      r'(?<![\d:-])(?<=\D|^)([0-2][0-4]:[0-5][0-9])|(:[0-5][0-9])(?=\D|$)(?![:\d-])';

  static const numPattern =
      r'(?<![\d:-])(?<=\D|^)([0-9]\d{3,})(?=\D|$)(?![:\d-])';

  static const ussdPattern =
      r'(?<![\d*:-])(?<=\D|^)(\*\d+(?:\*\d+)*#)(?=\D|$)(?![:\d-])';
}

Color stringToColor(String str) {
  // Generate an integer hash code for the string
  int hash = str.hashCode;

  // Mask the hash code with 0xFFFFFFFF to ensure it's a positive value
  hash = hash & 0xFFFFFFFF;

  // Generate a color from the hash code
  return Color(hash).withOpacity(1.0);
}

TextDirection getTextDirection(String text) {
  bool hasPersian = RegExp(r'[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u200C\u200F]+').hasMatch(text);
  bool hasNumbers = RegExp(r'\d').hasMatch(text);

  if (hasPersian) {
    return TextDirection.rtl;
  } else if (hasNumbers) {
    return TextDirection.ltr;
  } else {
    return TextDirection.ltr; // Default direction if neither Persian nor numbers are found
  }
}

TextDirection setDirectionInput(String text) {
  final isRTL = aa.Bidi.hasAnyRtl(text);
  return isRTL ? TextDirection.rtl : TextDirection.ltr;
}
