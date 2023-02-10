class LoginResponseModel {
  LoginResponseModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  int? statusCode;
  bool? status;
  String? message;
  LoginResponse? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: LoginResponse.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoginResponse {
  LoginResponse({
    this.manageUserId,
    this.uniqueId,
    this.name,
    this.email,
    this.token,
  });

  int? manageUserId;
  String? uniqueId;
  String? name;
  String? email;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    manageUserId: json["manage_user_id"],
    uniqueId: json["unique_id"],
    name: json["name"],
    email: json["email"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "manage_user_id": manageUserId,
    "unique_id": uniqueId,
    "name": name,
    "email": email,
    "token": token,
  };
}
