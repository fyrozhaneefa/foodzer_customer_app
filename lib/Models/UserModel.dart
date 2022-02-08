// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.loginStatus,
    this.data,
  });

  String? loginStatus;
  userData? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    loginStatus: json["login_status"] == null ? null : json["login_status"],
    data: json["data"] == null ? null : userData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "login_status": loginStatus == null ? null : loginStatus,
    "data": data == null ? null : data!.toJson(),
  };
}

class userData {
  userData({
    this.userId,
    this.userName,
    this.userEmail,
    this.userType,
    this.userCountry,
    this.userMobie,
  });

  String? userId;
  String? userName;
  String? userEmail;
  String? userType;
  String? userCountry;
  String? userMobie;

  factory userData.fromJson(Map<String, dynamic> json) => userData(
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userEmail: json["user_email"] == null ? null : json["user_email"],
    userType: json["user_type"] == null ? null : json["user_type"],
    userCountry: json["user_country"] == null ? null : json["user_country"],
    userMobie: json["user_mobie"] == null ? null : json["user_mobie"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "user_name": userName == null ? null : userName,
    "user_email": userEmail == null ? null : userEmail,
    "user_type": userType == null ? null : userType,
    "user_country": userCountry == null ? null : userCountry,
    "user_mobie": userMobie == null ? null : userMobie,
  };
}
