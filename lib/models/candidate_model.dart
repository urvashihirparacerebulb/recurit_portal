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
    this.candidateUniqueId,
    this.name,
    this.email,
    this.phone,
    this.manageUserId,
    this.status,
  });

  String? candidateUniqueId;
  String? name;
  String? email;
  String? phone;
  int? manageUserId;
  String? status;

  factory CandidateList.fromJson(Map<String, dynamic> json) => CandidateList(
    candidateUniqueId: json["candidate_unique_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    manageUserId: json["manage_user_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
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
    this.cityId,
    this.countryId,
    this.pincodeId,
    this.sameCorrespondenceAddress,
    this.cblockHouseNo,
    this.cstreet,
    this.clandmark,
    this.cpincode,
    this.cstate,
    this.ccity,
    this.ccountry,
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
  int? cityId;
  int? countryId;
  int? pincodeId;
  int? sameCorrespondenceAddress;
  String? cblockHouseNo;
  String? cstreet;
  String? clandmark;
  int? cpincode;
  int? cstate;
  int? ccity;
  int? ccountry;
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
    cityId: json["city_id"],
    countryId: json["country_id"],
    pincodeId: json["pincode_id"],
    sameCorrespondenceAddress: json["same_correspondence_address"],
    cblockHouseNo: json["cblock_house_no"],
    cstreet: json["cstreet"],
    clandmark: json["clandmark"],
    cpincode: json["cpincode"],
    cstate: json["cstate"],
    ccity: json["ccity"],
    ccountry: json["ccountry"],
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
    "city_id": cityId,
    "country_id": countryId,
    "pincode_id": pincodeId,
    "same_correspondence_address": sameCorrespondenceAddress,
    "cblock_house_no": cblockHouseNo,
    "cstreet": cstreet,
    "clandmark": clandmark,
    "cpincode": cpincode,
    "cstate": cstate,
    "ccity": ccity,
    "ccountry": ccountry,
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
    this.relativeName,
    this.relativeOccupation,
    this.relativeRelation,
    this.relativePhone,
    this.relativePhoneDialCode,
    this.relativePhoneCountryCode,
    this.relativeEmail,
  });

  int? candidateId;
  String? relativeName;
  String? relativeOccupation;
  String? relativeRelation;
  String? relativePhone;
  String? relativePhoneDialCode;
  String? relativePhoneCountryCode;
  String? relativeEmail;

  factory FamilyDetail.fromJson(Map<String, dynamic> json) => FamilyDetail(
    candidateId: json["candidate_id"],
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
    this.name,
    this.purpose,
    this.from,
    this.remark,
    this.attachment,
    this.status,
    this.manageUserId,
  });

  int? candidateId;
  String? name;
  String? purpose;
  String? from;
  String? remark;
  String? attachment;
  String? status;
  int? manageUserId;

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    candidateId: json["candidate_id"],
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
    "name": name,
    "purpose": purpose,
    "from": from,
    "remark": remark,
    "attachment": attachment,
    "status": status,
    "manage_user_id": manageUserId,
  };
}