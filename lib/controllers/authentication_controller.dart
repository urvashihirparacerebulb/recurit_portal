
import 'dart:convert';
import 'package:get/get.dart';

import '../candidate/candidate_list_view.dart';
import '../common_widgets/common_methods.dart';
import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import 'package:dio/dio.dart' as dio;

import '../models/login_response_model.dart';
import '../utility/common_methods.dart';
import 'general_controller.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get to => Get.find(); // add this

  void loginAPI(Map<String, dynamic> params) {
    apiServiceCall(
      params: params,
      serviceUrl: ApiConfig.loginURL,
      success: (dio.Response<dynamic> response) {
        LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(jsonDecode(response.data));
        showSnackBar(title: loginResponseModel.status! ? ApiConfig.success : ApiConfig.error, message: loginResponseModel.message ?? "");
        setObject(ApiConfig.loginPref, loginResponseModel);
        setIsLogin(isLogin: true);
        Get.offAll(() => const CandidateListView());
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST,
    );
  }

}