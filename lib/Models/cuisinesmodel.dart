class CuisinesModel {
  int? errorCode;
  List<CuisineList>? cuisineList;

  CuisinesModel({this.errorCode, this.cuisineList});

  CuisinesModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['cuisine_list'] != null) {
      cuisineList = <CuisineList>[];
      json['cuisine_list'].forEach((v) {
        cuisineList!.add(new CuisineList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    if (this.cuisineList != null) {
      data['cuisine_list'] = this.cuisineList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CuisineList {
  String? cuisineId;
  String? cuisineName;
  String? cuisineNameArabic;
  String? cuisineVisibility;
  String? cuisineDisplayOrder;
  String? cuisineAddedDate;
  String? cusineModifiedOn;
  String? cuisineDeleteStatus;
  String? displayOrder;

  CuisineList(
      {this.cuisineId,
        this.cuisineName,
        this.cuisineNameArabic,
        this.cuisineVisibility,
        this.cuisineDisplayOrder,
        this.cuisineAddedDate,
        this.cusineModifiedOn,
        this.cuisineDeleteStatus,
        this.displayOrder});

  CuisineList.fromJson(Map<String, dynamic> json) {
    cuisineId = json['cuisine_id'];
    cuisineName = json['cuisine_name'];
    cuisineNameArabic = json['cuisine_name_arabic'];
    cuisineVisibility = json['cuisine_visibility'];
    cuisineDisplayOrder = json['cuisine_display_order'];
    cuisineAddedDate = json['cuisine_added_date'];
    cusineModifiedOn = json['cusine_modified_on'];
    cuisineDeleteStatus = json['cuisine_delete_status'];
    displayOrder = json['display_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuisine_id'] = this.cuisineId;
    data['cuisine_name'] = this.cuisineName;
    data['cuisine_name_arabic'] = this.cuisineNameArabic;
    data['cuisine_visibility'] = this.cuisineVisibility;
    data['cuisine_display_order'] = this.cuisineDisplayOrder;
    data['cuisine_added_date'] = this.cuisineAddedDate;
    data['cusine_modified_on'] = this.cusineModifiedOn;
    data['cuisine_delete_status'] = this.cuisineDeleteStatus;
    data['display_order'] = this.displayOrder;
    return data;
  }
}