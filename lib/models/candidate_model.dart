import 'dart:io';

class CandidateListResponseModel {
  CandidateListResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  CandidateListResponse? data;

  factory CandidateListResponseModel.fromJson(Map<String, dynamic> json) => CandidateListResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: CandidateListResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CandidateListResponse {
  CandidateListResponse({
    this.data,
  });

  List<CandidateList>? data;

  factory CandidateListResponse.fromJson(Map<String, dynamic> json) => CandidateListResponse(
    data: List<CandidateList>.from(json["data"].map((x) => CandidateList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CandidateList {
  CandidateList({
    this.candidateId,
    this.candidateUniqueId,
    this.name,
    this.email,
    this.phone,
    this.manageUserId,
    this.status,
  });

  num? candidateId;
  String? candidateUniqueId;
  String? name;
  String? email;
  String? phone;
  int? manageUserId;
  String? status;

  factory CandidateList.fromJson(Map<String, dynamic> json) => CandidateList(
    candidateId: json["candidate_id"],
    candidateUniqueId: json["candidate_unique_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    manageUserId: json["manage_user_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "candidate_unique_id": candidateUniqueId,
    "name": name,
    "email": email,
    "phone": phone,
    "manage_user_id": manageUserId,
    "status": status,
  };
}

class CandidateDetailResponseModel {
  CandidateDetailResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  CandidateDetailResponse? data;

  factory CandidateDetailResponseModel.fromJson(Map<String, dynamic> json) => CandidateDetailResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: CandidateDetailResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CandidateDetailResponse {
  CandidateDetailResponse({
    required this.data,
  });

  List<CandidateDetail> data;

  factory CandidateDetailResponse.fromJson(Map<String, dynamic> json) => CandidateDetailResponse(
    data: List<CandidateDetail>.from(json["data"].map((x) => CandidateDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CandidateDetail {
  CandidateDetail({
    this.candidateId,
    this.name,
    this.dateOfBirth,
    this.email,
    this.emailTwo,
    this.phoneDialCode,
    this.phoneCountryCode,
    this.phone,
    this.phoneTwoDialCode,
    this.phoneTwoCountryCode,
    this.phoneTwo,
    this.gender,
    this.totalExperienceMonth,
    this.totalExperienceYear,
    this.blockHouseNo,
    this.streetLocality,
    this.landmark,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
    this.pincodeId,
    this.sameCorrespondenceAddress,
    this.cblockHouseNo,
    this.cstreet,
    this.clandmark,
    this.cpincode,
    this.correspondenceStateId,
    this.correspondenceStateName,
    this.correspondenceCityId,
    this.correspondenceCityName,
    this.correspondenceCountryId,
    this.correspondenceCountryName,
    this.currentCtc,
    this.expectedCtc,
    this.negotiable,
    this.noticePeriod,
    this.relocateStatus,
    this.workFromHome,
    this.bondStatus,
    this.bondYears,
    this.bondMonths,
    this.industryName,
    this.expertise,
    this.status,
  });

  int? candidateId;
  String? name;
  String? dateOfBirth;
  String? email;
  String? emailTwo;
  String? phoneDialCode;
  String? phoneCountryCode;
  String? phone;
  String? phoneTwoDialCode;
  String? phoneTwoCountryCode;
  String? phoneTwo;
  String? gender;
  String? totalExperienceMonth;
  String? totalExperienceYear;
  String? blockHouseNo;
  String? streetLocality;
  String? landmark;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  int? countryId;
  String? countryName;
  int? pincodeId;
  int? sameCorrespondenceAddress;
  String? cblockHouseNo;
  String? cstreet;
  String? clandmark;
  int? cpincode;
  int? correspondenceStateId;
  String? correspondenceStateName;
  int? correspondenceCityId;
  String? correspondenceCityName;
  int? correspondenceCountryId;
  String? correspondenceCountryName;

  String? currentCtc;
  String? expectedCtc;
  String? negotiable;
  String? noticePeriod;
  String? relocateStatus;
  String? workFromHome;
  String? bondStatus;
  String? bondYears;
  String? bondMonths;
  String? industryName;
  String? expertise;
  String? status;

  factory CandidateDetail.fromJson(Map<String, dynamic> json) => CandidateDetail(
    candidateId: json["candidate_id"],
    name: json["name"],
    dateOfBirth: json["date_of_birth"],
    email: json["email"],
    emailTwo: json["email_two"],
    phoneDialCode: json["phone_dial_code"],
    phoneCountryCode: json["phone_country_code"],
    phone: json["phone"],
    phoneTwoDialCode: json["phone_two_dial_code"],
    phoneTwoCountryCode: json["phone_two_country_code"],
    phoneTwo: json["phone_two"],
    gender: json["gender"],
    totalExperienceMonth: json["total_experience_month"],
    totalExperienceYear: json["total_experience_year"],
    blockHouseNo: json["block_house_no"],
    streetLocality: json["street_locality"],
    landmark: json["landmark"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    countryId: json["country_id"],
    countryName: json["country_name"],
    pincodeId: json["pincode_id"],
    sameCorrespondenceAddress: json["same_correspondence_address"],
    cblockHouseNo: json["cblock_house_no"],
    cstreet: json["cstreet"],
    clandmark: json["clandmark"],
    cpincode: json["cpincode"],
    correspondenceStateId: json["correspondence_state_id"],
    correspondenceStateName: json["correspondence_state_name"],
    correspondenceCityId: json["correspondence_city_id"],
    correspondenceCityName: json["correspondence_city_name"],
    correspondenceCountryId: json["correspondence_country_id"],
    correspondenceCountryName: json["correspondence_country_name"],
    currentCtc: json["current_ctc"],
    expectedCtc: json["expected_ctc"],
    negotiable: json["negotiable"],
    noticePeriod: json["notice_period"],
    relocateStatus: json["relocate_status"],
    workFromHome: json["work_from_home"],
    bondStatus: json["bond_status"],
    bondYears: json["bond_years"],
    bondMonths: json["bond_months"],
    industryName: json["industry_name"],
    expertise: json["expertise"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "name": name,
    "date_of_birth": dateOfBirth,
    "email": email,
    "email_two": emailTwo,
    "phone_dial_code": phoneDialCode,
    "phone_country_code": phoneCountryCode,
    "phone": phone,
    "phone_two_dial_code": phoneTwoDialCode,
    "phone_two_country_code": phoneTwoCountryCode,
    "phone_two": phoneTwo,
    "gender": gender,
    "total_experience_month": totalExperienceMonth,
    "total_experience_year": totalExperienceYear,
    "block_house_no": blockHouseNo,
    "street_locality": streetLocality,
    "landmark": landmark,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "country_id": countryId,
    "country_name": countryName,
    "pincode_id": pincodeId,
    "same_correspondence_address": sameCorrespondenceAddress,
    "cblock_house_no": cblockHouseNo,
    "cstreet": cstreet,
    "clandmark": clandmark,
    "cpincode": cpincode,
    "correspondence_state_id": correspondenceStateId,
    "correspondence_state_name": correspondenceStateName,
    "correspondence_city_id": correspondenceCityId,
    "correspondence_city_name": correspondenceCityName,
    "correspondence_country_id": correspondenceCountryId,
    "correspondence_country_name": correspondenceCountryName,
    "current_ctc": currentCtc,
    "expected_ctc": expectedCtc,
    "negotiable": negotiable,
    "notice_period": noticePeriod,
    "relocate_status": relocateStatus,
    "work_from_home": workFromHome,
    "bond_status": bondStatus,
    "bond_years": bondYears,
    "bond_months": bondMonths,
    "industry_name": industryName,
    "expertise": expertise,
    "status": status,
  };
}

class FamilyResponseModel {
  FamilyResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  FamilyResponse? data;

  factory FamilyResponseModel.fromJson(Map<String, dynamic> json) => FamilyResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: FamilyResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class FamilyResponse {
  FamilyResponse({
    this.data,
  });

  List<FamilyDetail>? data;

  factory FamilyResponse.fromJson(Map<String, dynamic> json) => FamilyResponse(
    data: List<FamilyDetail>.from(json["data"].map((x) => FamilyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FamilyDetail {
  FamilyDetail({
    this.candidateId,
    this.id,
    this.relativeName,
    this.relativeOccupation,
    this.relativeRelation,
    this.relativePhone,
    this.relativePhoneDialCode,
    this.relativePhoneCountryCode,
    this.relativeEmail,
  });

  int? candidateId;
  int? id;
  String? relativeName;
  String? relativeOccupation;
  String? relativeRelation;
  String? relativePhone;
  String? relativePhoneDialCode;
  String? relativePhoneCountryCode;
  String? relativeEmail;

  factory FamilyDetail.fromJson(Map<String, dynamic> json) => FamilyDetail(
    candidateId: json["candidate_id"],
    id: json["id"],
    relativeName: json["relative_name"],
    relativeOccupation: json["relative_occupation"],
    relativeRelation: json["relative_relation"],
    relativePhone: json["relative_phone"],
    relativePhoneDialCode: json["relative_phone_dial_code"],
    relativePhoneCountryCode: json["relative_phone_country_code"],
    relativeEmail: json["relative_email"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "relative_name": relativeName,
    "relative_occupation": relativeOccupation,
    "relative_relation": relativeRelation,
    "relative_phone": relativePhone,
    "relative_phone_dial_code": relativePhoneDialCode,
    "relative_phone_country_code": relativePhoneCountryCode,
    "relative_email": relativeEmail,
  };
}

class IdentificationResponseModel {
  IdentificationResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  IdentificationResponse? data;

  factory IdentificationResponseModel.fromJson(Map<String, dynamic> json) => IdentificationResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: IdentificationResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class IdentificationResponse {
  IdentificationResponse({
    this.data,
  });

  List<Identification>? data;

  factory IdentificationResponse.fromJson(Map<String, dynamic> json) => IdentificationResponse(
    data: List<Identification>.from(json["data"].map((x) => Identification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Identification {
  Identification({
    this.candidateId,
    this.id,
    this.idType,
    this.idNumber,
    this.issuedAuthority,
    this.issuedDate,
    this.expiredDate,
    this.attachment,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  int? id;
  String? idType;
  String? idNumber;
  String? issuedAuthority;
  String? issuedDate;
  String? expiredDate;
  String? attachment;
  String? status;
  int? manageUserId;

  factory Identification.fromJson(Map<String, dynamic> json) => Identification(
    candidateId: json["candidate_id"],
    id: json["id"],
    idType: json["id_type"],
    idNumber: json["id_number"],
    issuedAuthority: json["issued_authority"],
    issuedDate: json["issued_date"],
    expiredDate: json["expired_date"],
    attachment: json["attachment"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "id_type": idType,
    "id_number": idNumber,
    "issued_authority": issuedAuthority,
    "issued_date": issuedDate,
    "expired_date": expiredDate,
    "attachment": attachment,
    "status": status,
    "manage_user_id": manageUserId,
  };
}

class CertificationResponseModel {
  CertificationResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  CertificationResponse? data;

  factory CertificationResponseModel.fromJson(Map<String, dynamic> json) => CertificationResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: CertificationResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CertificationResponse {
  CertificationResponse({
    this.data,
  });

  List<Certification>? data;

  factory CertificationResponse.fromJson(Map<String, dynamic> json) => CertificationResponse(
    data: List<Certification>.from(json["data"].map((x) => Certification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Certification {
  Certification({
    this.candidateId,
    this.id,
    this.certificateName,
    this.issuingOrganization,
    this.issueMonth,
    this.doesNotExpire,
    this.expireMonth,
    this.credentialId,
    this.credentialUrl,
    this.attachment,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  int? id;
  String? certificateName;
  String? issuingOrganization;
  String? issueMonth;
  String? doesNotExpire;
  String? expireMonth;
  String? credentialId;
  String? credentialUrl;
  String? attachment;
  String? status;
  int? manageUserId;

  factory Certification.fromJson(Map<String, dynamic> json) => Certification(
    candidateId: json["candidate_id"],
    id: json["id"],
    certificateName: json["certificate_name"],
    issuingOrganization: json["issuing_organization"],
    issueMonth: json["issue_month"],
    doesNotExpire: json["does_not_expire"],
    expireMonth: json["expire_month"],
    credentialId: json["credential_id"],
    credentialUrl: json["credential_url"],
    attachment: json["attachment"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "certificate_name": certificateName,
    "issuing_organization": issuingOrganization,
    "issue_month": issueMonth,
    "does_not_expire": doesNotExpire,
    "expire_month": expireMonth,
    "credential_id": credentialId,
    "credential_url": credentialUrl,
    "attachment": attachment,
    "status": status,
    "manage_user_id": manageUserId,
  };
}

class AchievementsResponseModel {
  AchievementsResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AchievementsResponse? data;

  factory AchievementsResponseModel.fromJson(Map<String, dynamic> json) => AchievementsResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AchievementsResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AchievementsResponse {
  AchievementsResponse({
    this.data,
  });

  List<Achievement>? data;

  factory AchievementsResponse.fromJson(Map<String, dynamic> json) => AchievementsResponse(
    data: List<Achievement>.from(json["data"].map((x) => Achievement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Achievement {
  Achievement({
    this.candidateId,
    this.id,
    this.name,
    this.purpose,
    this.from,
    this.remark,
    this.attachment,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  int? id;
  String? name;
  String? purpose;
  String? from;
  String? remark;
  String? attachment;
  String? status;
  int? manageUserId;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    candidateId: json["candidate_id"],
    id: json["id"],
    name: json["name"],
    purpose: json["purpose"],
    from: json["from"],
    remark: json["remark"],
    attachment: json["attachment"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "name": name,
    "purpose": purpose,
    "from": from,
    "remark": remark,
    "attachment": attachment,
    "status": status,
    "manage_user_id": manageUserId,
  };
}

class SkillsResponseModel {
  SkillsResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  SkillsResponse? data;

  factory SkillsResponseModel.fromJson(Map<String, dynamic> json) => SkillsResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: SkillsResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class SkillsResponse {
  SkillsResponse({
    this.data,
  });

  List<Skills>? data;

  factory SkillsResponse.fromJson(Map<String, dynamic> json) => SkillsResponse(
    data: List<Skills>.from(json["data"].map((x) => Skills.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Skills {
  Skills({
    this.candidateId,
    this.id,
    this.skill,
    this.level,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  int? id;
  String? skill;
  String? level;
  String? status;
  int? manageUserId;

  factory Skills.fromJson(Map<String, dynamic> json) => Skills(
    candidateId: json["candidate_id"],
    id: json["id"],
    skill: json["skill"],
    level: json["level"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "skill": skill,
    "level": level,
    "status": status,
    "manage_user_id": manageUserId,
  };
}

class ReferenceResponseModel {
  ReferenceResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ReferenceResponse? data;

  factory ReferenceResponseModel.fromJson(Map<String, dynamic> json) => ReferenceResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ReferenceResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ReferenceResponse {
  ReferenceResponse({
    this.data,
  });

  List<Reference>? data;

  factory ReferenceResponse.fromJson(Map<String, dynamic> json) => ReferenceResponse(
    data: List<Reference>.from(json["data"].map((x) => Reference.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Reference {
  Reference({
    this.candidateId,
    this.id,
    this.referenceName,
    this.referenceDesignation,
    this.referenceEmail,
    this.referenceCompanyName,
    this.referencePhoneDialCode,
    this.referencePhoneCountryCode,
    this.referencePhone,
  });

  int? candidateId;
  int? id;
  String? referenceName;
  String? referenceDesignation;
  String? referenceEmail;
  String? referenceCompanyName;
  String? referencePhoneDialCode;
  String? referencePhoneCountryCode;
  String? referencePhone;

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
    candidateId: json["candidate_id"],
    id: json["id"],
    referenceName: json["reference_name"],
    referenceDesignation: json["reference_designation"],
    referenceEmail: json["reference_email"],
    referenceCompanyName: json["reference_company_name"],
    referencePhoneDialCode: json["reference_phone_dial_code"],
    referencePhoneCountryCode: json["reference_phone_country_code"],
    referencePhone: json["reference_phone"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "reference_name": referenceName,
    "reference_designation": referenceDesignation,
    "reference_email": referenceEmail,
    "reference_company_name": referenceCompanyName,
    "reference_phone_dial_code": referencePhoneDialCode,
    "reference_phone_country_code": referencePhoneCountryCode,
    "reference_phone": referencePhone,
  };
}

class LanguageResponseModel {
  LanguageResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  LanguageResponse? data;

  factory LanguageResponseModel.fromJson(Map<String, dynamic> json) => LanguageResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: LanguageResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LanguageResponse {
  LanguageResponse({
    this.data,
  });

  List<Language>? data;

  factory LanguageResponse.fromJson(Map<String, dynamic> json) => LanguageResponse(
    data: List<Language>.from(json["data"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Language {
  Language({
    this.language,
    this.id,
    this.read,
    this.write,
    this.speak,
  });

  String? language;
  int? id;
  String? read;
  String? write;
  String? speak;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    language: json["language"],
    id: json["id"],
    read: json["read"],
    write: json["write"],
    speak: json["speak"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "id": id,
    "read": read,
    "write": write,
    "speak": speak,
  };
}

class QualificationResponseModel {
  QualificationResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  QualificationResponse? data;

  factory QualificationResponseModel.fromJson(Map<String, dynamic> json) => QualificationResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: QualificationResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class QualificationResponse {
  QualificationResponse({
    this.data,
  });

  List<Qualification>? data;

  factory QualificationResponse.fromJson(Map<String, dynamic> json) => QualificationResponse(
    data: List<Qualification>.from(json["data"].map((x) => Qualification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Qualification {
  Qualification({
    this.candidateId,
    this.id,
    this.instituteName,
    this.departmentName,
    this.degreeName,
    this.fromMonth,
    this.toMonth,
    this.persuing,
    this.marksheet,
    this.certificate,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  int? id;
  String? instituteName;
  String? departmentName;
  String? degreeName;
  String? fromMonth;
  String? toMonth;
  String? persuing;
  List<ImageModel>? marksheet;
  String? certificate;
  String? status;
  int? manageUserId;

  factory Qualification.fromJson(Map<String, dynamic> json) => Qualification(
    candidateId: json["candidate_id"],
    id: json["id"],
    instituteName: json["institute_name"],
    departmentName: json["department_name"],
    degreeName: json["degree_name"],
    fromMonth: json["from_month"],
    toMonth: json["to_month"],
    persuing: json["persuing"],
    marksheet: List<ImageModel>.from(json["marksheet"].map((x) => ImageModel.fromJson(x))),
    certificate: json["certificate"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "institute_name": instituteName,
    "department_name": departmentName,
    "degree_name": degreeName,
    "from_month": fromMonth,
    "to_month": toMonth,
    "persuing": persuing,
    "marksheet": marksheet == null ? [] : List<dynamic>.from(marksheet!.map((x) => x.toJson())),
    "certificate": certificate,
    "status": status,
    "manage_user_id": manageUserId,
  };
}

class ImageModel {
  ImageModel({
    this.link,
    this.filename,
    this.filePath
  });

  String? link;
  String? filename;
  File? filePath;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    link: json["link"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "filename": filename,
  };
}

class ExperienceResponseModel {
  ExperienceResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  ExperienceResponse? data;

  factory ExperienceResponseModel.fromJson(Map<String, dynamic> json) => ExperienceResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: ExperienceResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ExperienceResponse {
  ExperienceResponse({
    this.data,
  });

  List<Experience>? data;

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) => ExperienceResponse(
    data: List<Experience>.from(json["data"].map((x) => Experience.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Experience {
  Experience({
    this.candidateId,
    this.id,
    this.occupationName,
    this.companyName,
    this.responsibility,
    this.currentlyWorking,
    this.fromMonths,
    this.toMonths,
    this.offerLetter,
    this.salarySlip,
    this.relievingLetter,
    this.experienceLetter,
    this.otherAttachement,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  int? id;
  String? occupationName;
  String? companyName;
  String? responsibility;
  String? fromMonths;
  String? toMonths;
  String? offerLetter;
  String? currentlyWorking;
  List<ImageModel>? salarySlip;
  String? relievingLetter;
  String? experienceLetter;
  List<ImageModel>? otherAttachement;
  String? status;
  int? manageUserId;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    candidateId: json["candidate_id"],
    id: json["id"],
    occupationName: json["occupation_name"],
    companyName: json["company_name"],
    responsibility: json["responsibility"],
    fromMonths: json["from_months"],
    currentlyWorking: json["currently_working"],
    toMonths: json["to_months"],
    offerLetter: json["offer_letter"],
    salarySlip: List<ImageModel>.from(json["salary_slip"].map((x) => ImageModel.fromJson(x))),
    relievingLetter: json["relieving_letter"],
    experienceLetter: json["experience_letter"],
    otherAttachement: List<ImageModel>.from(json["other_attachement"].map((x) => ImageModel.fromJson(x))),
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "id": id,
    "occupation_name": occupationName,
    "company_name": companyName,
    "responsibility": responsibility,
    "from_months": fromMonths,
    "currently_working": currentlyWorking,
    "to_months": toMonths,
    "offer_letter": offerLetter,
    "salary_slip": salarySlip == null ? [] : List<dynamic>.from(salarySlip!.map((x) => x.toJson())),
    "relieving_letter": relievingLetter,
    "experience_letter": experienceLetter,
    "other_attachement": otherAttachement == null ? [] : List<dynamic>.from(otherAttachement!.map((x) => x.toJson())),
    "status": status,
    "manage_user_id": manageUserId,
  };
}

class AttachmentsResponseModel {
  AttachmentsResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  AttachmentsResponse? data;

  factory AttachmentsResponseModel.fromJson(Map<String, dynamic> json) => AttachmentsResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: AttachmentsResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AttachmentsResponse {
  AttachmentsResponse({
    this.data,
  });

  List<Attachments>? data;

  factory AttachmentsResponse.fromJson(Map<String, dynamic> json) => AttachmentsResponse(
    data: json["data"] == null ? [] : List<Attachments>.from(json["data"].map((x) => Attachments.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Attachments {
  Attachments({
    this.candidateId,
    this.resume,
    this.coverLetter,
    this.otherAttachment,
  });

  int? candidateId;
  String? resume;
  String? coverLetter;
  List<ImageModel>? otherAttachment;

  factory Attachments.fromJson(Map<String, dynamic> json) => Attachments(
    candidateId: json["candidate_id"],
    resume: json["resume"],
    coverLetter: json["cover_letter"],
    otherAttachment: json["other_attachment"] == null ? [] : List<ImageModel>.from(json["other_attachment"].map((x) => ImageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "resume": resume,
    "cover_letter": coverLetter,
    "other_attachment": otherAttachment == null ? [] : List<dynamic>.from(otherAttachment!.map((x) => x.toJson())),
  };
}
