import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:freesms/data/models/contacts_model.dart';

import '../entities/failure.dart';

Future<Either<Failure, ContactsModel>> getContacts(offset, contactName) async {
  const platform = MethodChannel('flutter-free-sms-app/getContacts');

  bool requestResult = await FlutterContacts.requestPermission();
  if(true) {
    try {
      final String result = await platform.invokeMethod('getContacts', {'offset': offset, 'contactName': contactName});

      return Right(ContactsModel.fromJson(json.decode(result)));
    } on PlatformException catch (e) {
      return Left(Failure("Reading contacts failed because ${e.message}"));
    }
  } else {
    await FlutterContacts.requestPermission();
    return Left(Failure("Reading contacts failed because permission not granted, please accept it"));
  }
}