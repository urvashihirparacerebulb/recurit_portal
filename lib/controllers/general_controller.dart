import 'dart:convert';

import 'package:get/get.dart';

import '../common_widgets/common_methods.dart';
import '../configurations/config_file.dart';
import '../models/boolean_response_model.dart';
import '../utility/constants.dart';
import 'package:dio/dio.dart' as dio;

class GeneralController extends GetxController {
  static GeneralController get to => Get.find(); // add this

  RxBool isDarkMode = false.obs;
  RxString dashBoardTitle = basicInformation.obs;
}

void errorHandling(dio.Response<dynamic> response) {
  BooleanResponseModel? responseData =
  BooleanResponseModel.fromJson(jsonDecode(response.data));
  showSnackBar(title: ApiConfig.error, message: responseData.message ?? "");
}