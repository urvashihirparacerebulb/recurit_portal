import 'dart:convert';

import 'package:get/get.dart';

import '../configurations/api_service.dart';
import '../configurations/config_file.dart';
import 'package:dio/dio.dart' as dio;

import '../models/candidate_model.dart';
import 'general_controller.dart';

class CandidateController extends GetxController {
  static CandidateController get to => Get.find(); // add this
  RxList<CandidateList> candidateList = RxList<CandidateList>();
  RxList<FamilyDetail> candidateFamilyList = RxList<FamilyDetail>();
  RxList<Achievement> candidateAchievementsList = RxList<Achievement>();
  RxList<Identification> identificationList = RxList<Identification>();
  RxList<Certification> certificationList = RxList<Certification>();
  Rx<CandidateDetail> candidateDetail = CandidateDetail().obs;

  void getCandidateListData() {
    apiServiceCall(
      params: {
        "manage_user_id": 4
      },
      serviceUrl: ApiConfig.candidateListURL,
      success: (dio.Response<dynamic> response) {
        CandidateListResponseModel candidateListResponseModel = CandidateListResponseModel.fromJson(jsonDecode(response.data));
        candidateList.value = candidateListResponseModel.data!.data!;
      },
      error: (dio.Response<dynamic> response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void getCandidateBasicInfo({Function? callback}) {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchBasicDetailURL,
        success: (dio.Response<dynamic> response) {
          CandidateDetailResponseModel candidateDetailResponseModel = CandidateDetailResponseModel.fromJson(jsonDecode(response.data));
          candidateDetail.value = candidateDetailResponseModel.data!.data.first;
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getCandidateAddressInfo({Function? callback}) {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchAddressURL,
        success: (dio.Response<dynamic> response) {
          CandidateDetailResponseModel candidateDetailResponseModel = CandidateDetailResponseModel.fromJson(jsonDecode(response.data));
          candidateDetail.value = candidateDetailResponseModel.data!.data.first;
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getCandidateCompensationInfo({Function? callback}) {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchCandidateCompensationURL,
        success: (dio.Response<dynamic> response) {
          CandidateDetailResponseModel candidateDetailResponseModel = CandidateDetailResponseModel.fromJson(jsonDecode(response.data));
          candidateDetail.value = candidateDetailResponseModel.data!.data.first;
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getCandidateQuestionaryInfo({Function? callback}) {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchQuestionaryURL,
        success: (dio.Response<dynamic> response) {
          CandidateDetailResponseModel candidateDetailResponseModel = CandidateDetailResponseModel.fromJson(jsonDecode(response.data));
          candidateDetail.value = candidateDetailResponseModel.data!.data.first;
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getFamilyDetailInfo() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchFamilyDetailURL,
        success: (dio.Response<dynamic> response) {
          FamilyResponseModel familyResponseModel = FamilyResponseModel.fromJson(jsonDecode(response.data));
          candidateFamilyList.value = familyResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getIdentificationInfoList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchIdentificationListURL,
        success: (dio.Response<dynamic> response) {
          IdentificationResponseModel identificationResponseModel = IdentificationResponseModel.fromJson(jsonDecode(response.data));
          identificationList.value = identificationResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getCertificationInfoList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchCertificationListURL,
        success: (dio.Response<dynamic> response) {
          CertificationResponseModel certificationResponseModel = CertificationResponseModel.fromJson(jsonDecode(response.data));
          certificationList.value = certificationResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getIndustryInfo({Function? callback}) {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchIndustryURL,
        success: (dio.Response<dynamic> response) {
          CandidateDetailResponseModel candidateDetailResponseModel = CandidateDetailResponseModel.fromJson(jsonDecode(response.data));
          candidateDetail.value = candidateDetailResponseModel.data!.data.first;
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getAchievementsInfo() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": 275
        },
        serviceUrl: ApiConfig.fetchAchievementsListURL,
        success: (dio.Response<dynamic> response) {
          AchievementsResponseModel achievementsResponseModel = AchievementsResponseModel.fromJson(jsonDecode(response.data));
          candidateAchievementsList.value = achievementsResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

}