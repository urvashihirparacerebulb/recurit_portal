import 'dart:convert';
import 'package:cerebulb_recruit_portal/models/boolean_response_model.dart';
import 'package:cerebulb_recruit_portal/utility/common_methods.dart';
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
  RxList<Skills> skillsList = RxList<Skills>();
  RxList<Reference> referencesList = RxList<Reference>();
  RxList<Language> languagesList = RxList<Language>();
  RxList<Qualification> qualificationsList = RxList<Qualification>();
  RxList<Experience> experiencesList = RxList<Experience>();
  Rx<CandidateDetail> candidateDetail = CandidateDetail().obs;
  RxString candidateId = "275".obs;

  void getCandidateListData() {
    apiServiceCall(
      params: {
        "manage_user_id": getLoginData()!.data?.manageUserId
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
          "manage_user_id": getLoginData()!.data?.manageUserId,
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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
    certificationList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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
          "candidate_id": candidateId.value
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

  void getSkillsInfoList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": candidateId.value
        },
        serviceUrl: ApiConfig.fetchSkillsURL,
        success: (dio.Response<dynamic> response) {
          SkillsResponseModel skillsResponseModel = SkillsResponseModel.fromJson(jsonDecode(response.data));
          skillsList.value = skillsResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getReferencesList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": candidateId.value
        },
        serviceUrl: ApiConfig.fetchReferencesURL,
        success: (dio.Response<dynamic> response) {
          ReferenceResponseModel referenceResponseModel = ReferenceResponseModel.fromJson(jsonDecode(response.data));
          referencesList.value = referenceResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getLanguagesList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": candidateId.value
        },
        serviceUrl: ApiConfig.fetchLanguageInfoURL,
        success: (dio.Response<dynamic> response) {
          LanguageResponseModel languageResponseModel = LanguageResponseModel.fromJson(jsonDecode(response.data));
          languagesList.value = languageResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getQualificationsList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": candidateId.value
        },
        serviceUrl: ApiConfig.fetchQualificationURL,
        success: (dio.Response<dynamic> response) {
          QualificationResponseModel qualificationResponseModel = QualificationResponseModel.fromJson(jsonDecode(response.data));
          qualificationsList.value = qualificationResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void getExperiencesList() {
    apiServiceCall(
        params: {
          "manage_user_id": 4,
          "candidate_id": candidateId.value
        },
        serviceUrl: ApiConfig.fetchExperienceURL,
        success: (dio.Response<dynamic> response) {
          ExperienceResponseModel experienceResponseModel = ExperienceResponseModel.fromJson(jsonDecode(response.data));
          experiencesList.value = experienceResponseModel.data!.data ?? [];
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void deleteCertificate({String certificationId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteCertificateURL + certificationId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          if(experienceResponseModel.status ?? false){
            getCertificationInfoList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

}