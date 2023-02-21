class CountryStateResponseModel {
  CountryStateResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  CountryStateResponse? data;

  factory CountryStateResponseModel.fromJson(Map<String, dynamic> json) => CountryStateResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: CountryStateResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CountryStateResponse {
  CountryStateResponse({
    this.data,
  });

  List<CountryState>? data;

  factory CountryStateResponse.fromJson(Map<String, dynamic> json) => CountryStateResponse(
    data: List<CountryState>.from(json["data"].map((x) => CountryState.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CountryState {
  CountryState({
    this.id,
    this.name,
    this.pinCodeNo,
    this.status,
    this.countryId,
    this.stateId,
    this.manageUserId,
  });

  int? id;
  String? name;
  String? pinCodeNo;
  int? status;
  int? stateId;
  int? countryId;
  int? manageUserId;

  factory CountryState.fromJson(Map<String, dynamic> json) => CountryState(
    id: json["id"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    name: json["name"],
    pinCodeNo: json["pincode_no"],
    status: json["status"],
    manageUserId: json["manage_user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "state_id": stateId,
    "name": name,
    "pincode_no": pinCodeNo,
    "status": status,
    "manage_user_id": manageUserId,
  };
}


class AddressResponseModel {
  AddressResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  List<AddressResponse>? data;

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) => AddressResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: List<AddressResponse>.from(json["data"].map((x) => AddressResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AddressResponse {
  AddressResponse({
    this.pincodeId,
    this.pincodeNo,
    this.cityId,
    this.cityName,
    this.stateId,
    this.stateName,
    this.countryId,
    this.countryName,
  });

  int? pincodeId;
  String? pincodeNo;
  int? cityId;
  String? cityName;
  int? stateId;
  String? stateName;
  int? countryId;
  String? countryName;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
    pincodeId: json["pincode_id"],
    pincodeNo: json["pincode_no"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    countryId: json["country_id"],
    countryName: json["country_name"],
  );

  Map<String, dynamic> toJson() => {
    "pincode_id": pincodeId,
    "pincode_no": pincodeNo,
    "city_id": cityId,
    "city_name": cityName,
    "state_id": stateId,
    "state_name": stateName,
    "country_id": countryId,
    "country_name": countryName,
  };
}
