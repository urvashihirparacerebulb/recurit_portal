class ApiConfig {

  static const String baseURL = "https://recruit.cerebulb.com/api/";
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

  static const String methodPOST = "post";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";

  static const String error = "Error";
  static const String success = "Success";
  static const String warning = "Warning";

  static const String loginPref = "loginPref";
}
