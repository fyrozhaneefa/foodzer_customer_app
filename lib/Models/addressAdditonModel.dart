class DisplayAddressModel {
  List<AddressList>? addressList;

  DisplayAddressModel({this.addressList});

  DisplayAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['address_list'] != null) {
      addressList = <AddressList>[];
      json['address_list'].forEach((v) {
        addressList!.add(new AddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressList != null) {
      data['address_list'] = this.addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressList {
  String? addressId;
  String? addressUser;
  String? addressName;
  String? addressMobNo;
  String? addressLandLine;
  String? addressCity;
  String? addressArea;
  String? addressPropType;
  Null? addrerssCityName;
  String? addressStreetName;
  String? addressFlour;
  String? addressTitle;
  String? addressBuilding;
  String? addressDirection;
  String? adressApartmentNo;
  Null? addressCreateOn;
  String? addressTimestamp;
  String? addressLat;
  String? addressLng;
  Null? areaName;
  Null? cityName;

  AddressList(
      {this.addressId,
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
        this.cityName});

  AddressList.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressUser = json['address_user'];
    addressName = json['address_name'];
    addressMobNo = json['address_mob_no'];
    addressLandLine = json['address_land_line'];
    addressCity = json['address_city'];
    addressArea = json['address_area'];
    addressPropType = json['address_prop_type'];
    addrerssCityName = json['addrerss_city_name'];
    addressStreetName = json['address_street_name'];
    addressFlour = json['address_flour'];
    addressTitle = json['address_title'];
    addressBuilding = json['address_building'];
    addressDirection = json['address_direction'];
    adressApartmentNo = json['adress_apartment_no'];
    addressCreateOn = json['address_create_on'];
    addressTimestamp = json['address_timestamp'];
    addressLat = json['address_lat'];
    addressLng = json['address_lng'];
    areaName = json['area_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_user'] = this.addressUser;
    data['address_name'] = this.addressName;
    data['address_mob_no'] = this.addressMobNo;
    data['address_land_line'] = this.addressLandLine;
    data['address_city'] = this.addressCity;
    data['address_area'] = this.addressArea;
    data['address_prop_type'] = this.addressPropType;
    data['addrerss_city_name'] = this.addrerssCityName;
    data['address_street_name'] = this.addressStreetName;
    data['address_flour'] = this.addressFlour;
    data['address_title'] = this.addressTitle;
    data['address_building'] = this.addressBuilding;
    data['address_direction'] = this.addressDirection;
    data['adress_apartment_no'] = this.adressApartmentNo;
    data['address_create_on'] = this.addressCreateOn;
    data['address_timestamp'] = this.addressTimestamp;
    data['address_lat'] = this.addressLat;
    data['address_lng'] = this.addressLng;
    data['area_name'] = this.areaName;
    data['city_name'] = this.cityName;
    return data;
  }
}