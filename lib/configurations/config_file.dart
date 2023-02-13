class ApiConfig {

  static const String baseURL = "https://recruit.cerebulb.com/api/";
  static const String loginURL = "${baseURL}login";
  static const String candidateListURL = "${baseURL}candidate-list";
  static const String fetchBasicDetailURL = "${baseURL}fetch-candidate-basic-info";
  static const String fetchAddressURL = "${baseURL}fetch-candidate-address-info";
  static const String fetchCandidateCompensationURL = "${baseURL}fetch-candidate-compensation-info";
  static const String fetchQuestionaryURL = "${baseURL}fetch-candidate-questionary-info";
  static const String fetchFamilyDetailURL = "${baseURL}fetch-family-info";
  static const String fetchIndustryURL = "${baseURL}fetch-candidate-industry-info";
  static const String fetchIdentificationListURL = "${baseURL}fetch-identification";
  static const String fetchCertificationListURL = "${baseURL}fetch-certification";
  static const String fetchAchievementsListURL = "${baseURL}fetch-achievement";
  static const String fetchSkillsURL = "${baseURL}fetch-skills";
  static const String fetchReferencesURL = "${baseURL}fetch-reference-info";
  static const String fetchLanguageInfoURL = "${baseURL}fetch-language-info";
  static const String fetchQualificationURL = "${baseURL}fetch-qualification";
  static const String fetchExperienceURL = "${baseURL}fetch-experience";

  static const String deleteCertificateURL = "${baseURL}delete-candidate-certification/";
  static const String deleteAchievementURL = "${baseURL}delete-candidate-achievement/";
  static const String deleteSkillsURL = "${baseURL}delete-candidate-skills/";
  static const String deleteFamilyInfoURL = "${baseURL}delete-candidate-family-info/";
  static const String deleteReferenceURL = "${baseURL}delete-candidate-reference-info/";
  static const String deleteLanguageURL = "${baseURL}delete-candidate-language-info/";
  static const String deleteQualificationURL = "${baseURL}delete-candidate-qualification/";
  static const String deleteExperienceURL = "${baseURL}delete-candidate-experience/";

  static const String updateBasicInformationURL = "${baseURL}update-candidate-basic-info/";

  static const String methodPOST = "post";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";

  static const String error = "Error";
  static const String success = "Success";
  static const String warning = "Warning";

  static const String loginPref = "loginPref";
}
