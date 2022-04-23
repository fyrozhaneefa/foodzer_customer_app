// To parse this JSON data, do
//
//     final getAddressModel = getAddressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());


class AddressModel {
  AddressModel({
    this.addressId,
    this.addressUser,
    this.addressName,
    this.addressMobNo,
    this.addressLandLine,
    this.addressCity,
    this.addressArea,
    this.addressPropType,
    this.addrerssCityName,
    this.addressStreetName,
    this.addressFlour,
    this.addressTitle,
    this.addressBuilding,
    this.addressDirection,
    this.adressApartmentNo,
    this.addressCreateOn,
    this.addressTimestamp,
    this.addressLat,
    this.addressLng,
    this.areaName,
    this.cityName,
    this.currentAddressLine
  });

  String? addressId;
  String? addressUser;
  String? addressName;
  String? addressMobNo;
  dynamic addressLandLine;
  dynamic addressCity;
  dynamic addressArea;
  String? addressPropType;
  dynamic addrerssCityName;
  String? addressStreetName;
  String? addressFlour;
  String? addressTitle;
  String? addressBuilding;
  String? addressDirection;
  String? adressApartmentNo;
  dynamic addressCreateOn;
  DateTime? addressTimestamp;
  String? addressLat;
  String? addressLng;
  dynamic areaName;
  dynamic cityName;
  String? currentAddressLine;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    addressId: json["address_id"] == null ? null : json["address_id"],
    addressUser: json["address_user"] == null ? null : json["address_user"],
    addressName: json["address_name"] == null ? null : json["address_name"],
    addressMobNo: json["address_mob_no"] == null ? null : json["address_mob_no"],
    addressLandLine: json["address_land_line"],
    addressCity: json["address_city"],
    addressArea: json["address_area"],
    addressPropType: json["address_prop_type"] == null ? null : json["address_prop_type"],
    addrerssCityName: json["addrerss_city_name"],
    addressStreetName: json["address_street_name"] == null ? null : json["address_street_name"],
    addressFlour: json["address_flour"] == null ? null : json["address_flour"],
    addressTitle: json["address_title"] == null ? null : json["address_title"],
    addressBuilding: json["address_building"] == null ? null : json["address_building"],
    addressDirection: json["address_direction"] == null ? null : json["address_direction"],
    adressApartmentNo: json["adress_apartment_no"] == null ? null : json["adress_apartment_no"],
    addressCreateOn: json["address_create_on"],
    addressTimestamp: json["address_timestamp"] == null ? null : DateTime.parse(json["address_timestamp"]),
    addressLat: json["address_lat"] == null ? null : json["address_lat"],
    addressLng: json["address_lng"] == null ? null : json["address_lng"],
    areaName: json["area_name"],
    cityName: json["city_name"],
    currentAddressLine:json["current_addressline"] == null ? null : json["current_addressline"],
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId == null ? null : addressId,
    "address_user": addressUser == null ? null : addressUser,
    "address_name": addressName == null ? null : addressName,
    "address_mob_no": addressMobNo == null ? null : addressMobNo,
    "address_land_line": addressLandLine,
    "address_city": addressCity,
    "address_area": addressArea,
    "address_prop_type": addressPropType == null ? null : addressPropType,
    "addrerss_city_name": addrerssCityName,
    "address_street_name": addressStreetName == null ? null : addressStreetName,
    "address_flour": addressFlour == null ? null : addressFlour,
    "address_title": addressTitle == null ? null : addressTitle,
    "address_building": addressBuilding == null ? null : addressBuilding,
    "address_direction": addressDirection == null ? null : addressDirection,
    "adress_apartment_no": adressApartmentNo == null ? null : adressApartmentNo,
    "address_create_on": addressCreateOn,
    "address_timestamp": addressTimestamp == null ? null : addressTimestamp,
    "address_lat": addressLat == null ? null : addressLat,
    "address_lng": addressLng == null ? null : addressLng,
    "area_name": areaName,
    "city_name": cityName,
    "current_addressline" : currentAddressLine,
  };
}
