import 'dart:convert';
import 'dart:io';
import 'package:cerebulb_recruit_portal/models/boolean_response_model.dart';
import 'package:cerebulb_recruit_portal/utility/common_methods.dart';
import 'package:get/get.dart';

import '../common_widgets/common_methods.dart';
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
  Rx<Attachments> attachmentDetail = Attachments().obs;
  RxString candidateId = "275".obs;

  void getCandidateListData() {
    candidateList.clear();
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
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    candidateFamilyList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    identificationList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    candidateAchievementsList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    skillsList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    referencesList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    languagesList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    qualificationsList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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
    experiencesList.clear();
    apiServiceCall(
        params: {
          "manage_user_id": getLoginData()!.data?.manageUserId,
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

  void getAttachmentsList({Function? callback}) {
    apiServiceCall(
        params: {
          "candidate_id": candidateId.value
        },
        serviceUrl: ApiConfig.fetchAttachmentURL,
        success: (dio.Response<dynamic> response) {
          AttachmentsResponseModel attachmentsResponse = AttachmentsResponseModel.fromJson(jsonDecode(response.data));
          if(attachmentsResponse.data!.data != null) {
            attachmentDetail.value = attachmentsResponse.data!.data!.first;
            callback!();
          }
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
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
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

  void deleteAchievement({String achievementId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteAchievementURL + achievementId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getAchievementsInfo();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteSkill({String skillId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteSkillsURL + skillId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getSkillsInfoList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteFamilyInfo({String familyInfoId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteFamilyInfoURL + familyInfoId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getFamilyDetailInfo();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteReference({String refId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteReferenceURL + refId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getReferencesList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteLanguage({String lanId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteLanguageURL + lanId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getLanguagesList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteQualification({String qulID = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteQualificationURL + qulID,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getQualificationsList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteExperience({String expId = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteExperienceURL + expId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getExperiencesList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void deleteIdentification({String id = ""}) {
    apiServiceCall(
        params: {},
        serviceUrl: ApiConfig.deleteIdentificationURL + id,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(response.data);
          if(experienceResponseModel.status ?? false){
            getIdentificationInfoList();
          }
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodDELETE
    );
  }

  void updateBasicInformation({String infoId = "", Function? callback,String? name,
    dob,email,emailTwo,pDialCode,pCountryCode,phone,pTwoDialCode,pTwoCountryCode,phoneTwo,
    gender,totalExpMonth,totalExpYear,status
  }) {
    apiServiceCall(
        params: {
          "name": name,
          "date_of_birth": dob,
          "email": email,
          "email_two": emailTwo,
          "phone_dial_code": pDialCode,
          "phone_country_code": pCountryCode,
          "phone": phone,
          "phone_two_dial_code": pTwoDialCode,
          "phone_two_country_code": pTwoCountryCode,
          "phone_two": phoneTwo,
          "gender": gender,
          "total_experience_month": totalExpMonth,
          "total_experience_year": totalExpYear,
          "status": status,
          "manage_user_id": getLoginData()!.data?.manageUserId.toString(),
          "updated_at": DateTime.now().toString()
        },
        serviceUrl: ApiConfig.updateBasicInformationURL + infoId,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          showSnackBar(title: ApiConfig.success, message: experienceResponseModel.message ?? "");
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void updateAddressView({Function? callback,String? blockNo,
    street,landmark,stateId,cityId,countryId,pinCode,cblockNo,cStreet,cLandmark,
    cState,cCity,cCountry,cPinCode, bool sameAddress = false
  }) {
    apiServiceCall(
        params: {
          "block_house_no": blockNo,
          "street_locality": street,
          "landmark": landmark,
          "state_id": stateId,
          "city_id": cityId,
          "country_id": countryId,
          "pincode_id": pinCode,
          "same_correspondence_address": sameAddress == true ? "Yes" : "",
          "cblock_house_no": cblockNo,
          "cstreet": cStreet,
          "clandmark": cLandmark,
          "cstate": cState,
          "ccity": cCity,
          "ccountry": cCountry,
          "cpincode": cPinCode,
          "status": "Active",
          "manage_user_id": getLoginData()!.data?.manageUserId.toString(),
          "updated_at": DateTime.now().toString()
        },
        serviceUrl: ApiConfig.updateAddressURL + candidateId.value,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          showSnackBar(title: ApiConfig.success, message: experienceResponseModel.message ?? "");
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void updateCompensationView({String currentCTC = "",expectedCTC, status,bool isNegotiable = false, Function? callback}) {
    apiServiceCall(
        params: {
          "current_ctc": currentCTC,
          "expected_ctc": expectedCTC,
          "negotiable": isNegotiable ? "yes" : "no",
          "status": status,
          "manage_user_id": getLoginData()!.data?.manageUserId,
          "updated_at": DateTime.now().toString()
        },
        serviceUrl: ApiConfig.updateCompensationURL + candidateId.value,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          showSnackBar(title: ApiConfig.success, message: experienceResponseModel.message ?? "");
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void updateQuestionaryView({String months = "",years, status,
    noticePeriod,bool relocateStatus = false,bool wfh = false,bool bondStatus = false,
    Function? callback}) {
    apiServiceCall(
        params: {
          "notice_period": noticePeriod,
          "bond_months": months,
          "bond_years": years,
          "relocate_status": relocateStatus ? "yes" : "no",
          "work_from_home": wfh ? "yes" : "no",
          "bond_status": bondStatus ? "yes" : "no",
          "status": status,
          "manage_user_id": getLoginData()!.data?.manageUserId,
          "updated_at": DateTime.now().toString()
        },
        serviceUrl: ApiConfig.updateQuestionaryURL + candidateId.value,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          showSnackBar(title: ApiConfig.success, message: experienceResponseModel.message ?? "");
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void updateIndustryView({String industryName = "",expertise, status,Function? callback}) {
    apiServiceCall(
        params: {
          "industry_name": industryName,
          "expertise": expertise,
          "status": status,
          "manage_user_id": getLoginData()!.data?.manageUserId,
          "updated_at": DateTime.now().toString()
        },
        serviceUrl: ApiConfig.updateIndustryInfoURL + candidateId.value,
        success: (dio.Response<dynamic> response) {
          BooleanResponseModel experienceResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          showSnackBar(title: ApiConfig.success, message: experienceResponseModel.message ?? "");
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditIdentificationView({String idType = "",idNumber, issuedAuthority, issuedDate, expiryDate, status,
      bool isEdit = false,
      String indentificationId = "",
      File? attachment,
      Function? callback}) async {
      dio.FormData formData = dio.FormData.fromMap({
        "candidate_id": candidateId.value,
        "id_type": idType,
        "id_number": idNumber,
        "issued_authority": issuedAuthority,
        "issued_date": issuedDate,
        "expired_date": expiryDate,
        "status": status,
        "manage_user_id": getLoginData()!.data?.manageUserId,
        "updated_at": DateTime.now().toString()
      });

      if(!isEdit){
        formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
      }

      if(attachment != null){
        formData.files.add(
            MapEntry("attachment", await dio
                    .MultipartFile.fromFile(attachment.path)),);
      }
      apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateIndentificationURL + indentificationId) : ApiConfig.addIdentificationURL,
        success: (dio.Response<dynamic> response) {
          // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditCertificationView({String certificateName = "",issuingOrg, issueMonth, expireMonth, credId, credURL, status,
    bool isEdit = false,
    bool isNotExpire = false,
    String certificationId = "",
    File? attachment,
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "certificate_name": certificateName,
      "issuing_organization": issuingOrg,
      "does_not_expire": isNotExpire ? "Yes" : "",
      "issue_month": issueMonth,
      "expire_month": isNotExpire ? "" : expireMonth,
      "credential_id": credId,
      "credential_url": credURL,
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    if(attachment != null){
      formData.files.add(
        MapEntry("attachment", await dio
            .MultipartFile.fromFile(attachment.path)),);
    }
    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateCertificationURL + certificationId) : ApiConfig.addCertificationURL,
        success: (dio.Response<dynamic> response) {
          // BooleanResponseModel booleanResponseModel = BooleanResponseModel.fromJson(jsonDecode(response.data));
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditAchievementView({String name = "",purpose, from, remark, status,
    bool isEdit = false,
    String achievementId = "",
    File? attachment,
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "name": name,
      "purpose": purpose,
      "from": from,
      "remark": remark,
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    if(attachment != null){
      formData.files.add(
        MapEntry("attachment", await dio
            .MultipartFile.fromFile(attachment.path)));
    }
    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateAchievementURL + achievementId) : ApiConfig.addAchievementURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditSkillsView({String skill = "",level, status,
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "skill": skill,
      "level": level,
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "created_at": DateTime.now().toString(),
      "updated_at": DateTime.now().toString()
    });

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: ApiConfig.addSkillURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditFamilyDetailView({String name = "",occupation, relation, phone, email, status, countryCode, dialCode,
    bool isEdit = false,
    String relativeId = "",
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "relative_name": name,
      "relative_occupation": occupation,
      "relative_relation": relation,
      "relative_phone": phone,
      "relative_email": email,
      "relative_phone_dial_code": dialCode,
      "relative_phone_country_code": countryCode,
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateFamilyInfoURL + relativeId) : ApiConfig.addFamilyInfoURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditReferenceInfo({String name = "",designation, companyName, phone, email, status, countryCode, dialCode,
    bool isEdit = false,
    String referenceId = "",
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "reference_name": name,
      "reference_company_name": companyName,
      "reference_designation": designation,
      "reference_phone": phone,
      "reference_email": email,
      "reference_phone_dial_code": dialCode,
      "reference_phone_country_code": countryCode,
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateReferenceURL + referenceId) : ApiConfig.addReferenceURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditLanguageInfo({String langName = "",status, bool? isRead, isWrite, isSpeak,
    bool isEdit = false,
    String langId = "",
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "language": langName,
      "read": isRead! ? "Yes" : "",
      "write": isWrite ? "Yes" : "",
      "speak": isSpeak ? "Yes" : "",
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateLanguageURL + langId) : ApiConfig.addLanguageURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditQualificationInfo({String name = "",department, degreeName, fromMonth, toMonth, status, bool persuing = false ,
    bool isEdit = false,
    File? certificate,
    List<File> markSheets = const [],
    String qualificationId = "",
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "institute_name": name,
      "department_name": department,
      "degree_name": degreeName,
      "from_month": fromMonth,
      "persuing": persuing ? "Yes" : "",
      "to_month": !persuing ? toMonth : "",
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    if(certificate != null){
      formData.files.add(
          MapEntry("certificate", await dio
              .MultipartFile.fromFile(certificate.path)));
    }

    if(markSheets.isNotEmpty){
      for(int i = 0; i < markSheets.length; i++){
        formData.files.add(
            MapEntry("marksheet[$i]", await dio
                .MultipartFile.fromFile(markSheets[i].path)));
      }
    }

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateQualificationURL + qualificationId) : ApiConfig.addQualificationURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> addEditExperienceInfo({String name = "",companyName, responsibility, fromMonth, toMonth, status, bool currentlyWorking = false ,
    bool isEdit = false,
    File? offerLetter,
    File? relievingLetter,
    File? experienceLetter,
    List<File> salarySlips = const [],
    List<File> otherAttachments = const [],
    String expId = "",
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "candidate_id": candidateId.value,
      "occupation_name": name,
      "company_name": companyName,
      "responsibility": responsibility,
      "from_months": fromMonth,
      "currently_working": currentlyWorking ? "Yes" : "",
      "to_months": toMonth,
      "status": status,
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(!isEdit){
      formData.fields.add(MapEntry("created_at", DateTime.now().toString()));
    }

    if(offerLetter != null){
      formData.files.add(
          MapEntry("offer_letter", await dio
              .MultipartFile.fromFile(offerLetter.path)));
    }
    if(relievingLetter != null){
      formData.files.add(
          MapEntry("relieving_letter", await dio
              .MultipartFile.fromFile(relievingLetter.path)));
    }
    if(experienceLetter != null){
      formData.files.add(
          MapEntry("experience_letter", await dio
              .MultipartFile.fromFile(experienceLetter.path)));
    }

    if(salarySlips.isNotEmpty){
      for(int i = 0; i < salarySlips.length; i++){
        formData.files.add(
            MapEntry("salary_slip[$i]", await dio
                .MultipartFile.fromFile(salarySlips[i].path)));
      }
    }
    if(otherAttachments.isNotEmpty){
      for(int i = 0; i < otherAttachments.length; i++){
        formData.files.add(
            MapEntry("other_attachement[$i]", await dio
                .MultipartFile.fromFile(otherAttachments[i].path)));
      }
    }

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: isEdit ? (ApiConfig.updateExperienceURL + expId) : ApiConfig.addExperienceURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  Future<void> editAttachmentsInfo({File? coverLetter,
    File? resume,
    List<ImageModel> otherAttachments = const [],
    Function? callback}) async {
    dio.FormData formData = dio.FormData.fromMap({
      "status": "Active",
      "manage_user_id": getLoginData()!.data?.manageUserId,
      "updated_at": DateTime.now().toString()
    });

    if(coverLetter != null){
      formData.files.add(
          MapEntry("cover_letter", await dio
              .MultipartFile.fromFile(coverLetter.path)));
    }
    if(resume != null){
      formData.files.add(
          MapEntry("resume", await dio
              .MultipartFile.fromFile(resume.path)));
    }

    if(otherAttachments.isNotEmpty){
      for(int i = 0; i < otherAttachments.length; i++){
        if(otherAttachments[i].filename == "" && otherAttachments[i].link == "") {
          formData.files.add(
              MapEntry("other_attachment[$i]", await dio
                  .MultipartFile.fromFile(otherAttachments[i].filePath!.path)));
        }
      }
    }

    apiServiceCall(
        params: {},
        formValues: formData,
        serviceUrl: ApiConfig.updateAttachmentURL + candidateId.value,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }


  void deleteOtherAttachment({String docName = "", Function? callback}) {
    apiServiceCall(
        params: {
          "candidate_id": candidateId.value,
          "filename": docName
        },
        serviceUrl: ApiConfig.deleteOtherAttachmentURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void deleteOtherAttachmentsForExperience({String docName = "", expId,Function? callback}) {
    apiServiceCall(
        params: {
          "experience_id": expId,
          "filename": docName
        },
        serviceUrl: ApiConfig.deleteOtherAttachmentExperienceURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void deleteSalarySlipsExperience({String docName = "", expId,Function? callback}) {
    apiServiceCall(
        params: {
          "experience_id": expId,
          "filename": docName
        },
        serviceUrl: ApiConfig.deleteSalarySlipsExperienceURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void deleteMarkSheetsInQualification({String docName = "", qulId,Function? callback}) {
    apiServiceCall(
        params: {
          "qualification_id": qulId,
          "filename": docName
        },
        serviceUrl: ApiConfig.deleteMarkSheetURL,
        success: (dio.Response<dynamic> response) {
          callback!();
        },
        error: (dio.Response<dynamic> response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }
}