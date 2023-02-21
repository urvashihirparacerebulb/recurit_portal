import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import '../models/address_model.dart';
import '../utility/common_methods.dart';
import 'general_controller.dart';

class AddressController extends GetxController {
  static AddressController get to => Get.find(); // add this

  RxList<CountryState> countriesList = RxList<CountryState>();
  RxList<CountryState> statesList = RxList<CountryState>();
  RxList<CountryState> citiesList = RxList<CountryState>();
  RxList<CountryState> pinCodesList = RxList<CountryState>();


  void getCountriesList({Function? callback}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.fetchCountriesURL,
        success: (dio.Response<dynamic> response) {
          CountryStateResponseModel countryStateResponseModel = CountryStateResponseModel.fromJson(jsonDecode(response.data));
          countriesList.addAll(countryStateResponseModel.data!.data ?? []);
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getStatesList({String? countryId, Function? callback}) {
    apiServiceCall(
        params: {
          "country_id": countryId
        },
        serviceUrl: ApiConfig.fetchStatesURL,
        success: (dio.Response<dynamic> response) {
          CountryStateResponseModel countryStateResponseModel = CountryStateResponseModel.fromJson(jsonDecode(response.data));
          statesList.addAll(countryStateResponseModel.data!.data ?? []);
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getCitiesList({String? stateId, Function? callback}) {
    apiServiceCall(
        params: {
          "state_id": stateId
        },
        serviceUrl: ApiConfig.fetchCityURL,
        success: (dio.Response<dynamic> response) {
          CountryStateResponseModel countryStateResponseModel = CountryStateResponseModel.fromJson(jsonDecode(response.data));
          citiesList.addAll(countryStateResponseModel.data!.data ?? []);
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getPinCodesList({Function? callback}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.fetchPinCodesURL,
        success: (dio.Response<dynamic> response) {
          CountryStateResponseModel countryStateResponseModel = CountryStateResponseModel.fromJson(jsonDecode(response.data));
          pinCodesList.addAll(countryStateResponseModel.data!.data ?? []);
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void addNewPinCode({String pinCode = "", cityId}) {
    apiServiceCall(
        params: {
          "pincode_no": pinCode,
          "city_id": cityId,
          "status": 0,
          "manage_user_id": getLoginData()!.data?.manageUserId,
          "created_at": DateTime.now().toString(),
          "updated_at": DateTime.now().toString()
        },
        serviceUrl: ApiConfig.addNewPinCode,
        success: (dio.Response<dynamic> response) {
          Get.back();

        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

}
