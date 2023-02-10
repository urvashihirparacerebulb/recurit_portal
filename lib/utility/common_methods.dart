import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../configurations/config_file.dart';
import '../main.dart';
import '../models/login_response_model.dart';
import 'color_utility.dart';

isNotEmptyString(String? string) {
  return string != null && string.isNotEmpty;
}
double commonHorizontalPadding = 10.0;

setIsLogin({required bool isLogin}) {
  getPreferences.write('isLogin', isLogin);
}

bool getIsLogin() {
  return (getPreferences.read('isLogin') ?? false);
}

setObject(String key, value) {
  getPreferences.write(key, json.encode(value));
}

getObject(String key) {
  return getPreferences.read(key) != null
      ? json.decode(getPreferences.read(key))
      : null;
}

LoginResponseModel? getLoginData() {
  if (getObject(ApiConfig.loginPref) != null) {
    LoginResponseModel loginResponse =
    LoginResponseModel.fromJson(getObject(ApiConfig.loginPref));
    return loginResponse;
  } else {
    return null;
  }
}

Future<DateTime> openCalendarView(BuildContext buildContext, {int selectedYear = 15,
  required String initialDate, String? firstDate}) async {
  DateTime? initialDateObj;
  if (initialDate != "") {
    initialDateObj = DateFormat("yyyy-MM-dd").parse(initialDate);
  }
  DateTime? picked = await showDatePicker(
    context: buildContext,
    initialDate: (initialDateObj ?? DateTime(DateTime
        .now()
        .year - selectedYear)),
    // initialDateObj == null ? DateTime.now() : initialDateObj,
    firstDate: DateTime(DateTime.now().year - 100),
    // (date != null ? date : DateTime(DateTime.now().year - selectedYear)),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (context, child) {
      return Theme(data: ThemeData.light().copyWith(colorScheme: const ColorScheme.light(onPrimary: bgColor,primary: primaryColor,surface: primaryColor)), child: child!);
    },
  );
  if (picked != null) return picked;
  return DateTime.now();
}