class SpecialCategoryModel {
  int? errorCode;
  List<SpecialCategories>? specialCategories;


  SpecialCategoryModel({this.errorCode, this.specialCategories,});

  SpecialCategoryModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['special_categories'] != null) {
      specialCategories = <SpecialCategories>[];
      json['special_categories'].forEach((v) {
        specialCategories!.add(new SpecialCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    if (this.specialCategories != null) {
      data['special_categories'] =
          this.specialCategories!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class SpecialCategories {
  String? id;
  String? categoryName;
  String? categoryImage;
  String? resturants;
  String? displayOrder;
  String? visibility;
  String? status;
  String? dateCreated;

  SpecialCategories(
      {this.id,
        this.categoryName,
        this.categoryImage,
        this.resturants,
        this.displayOrder,
        this.visibility,
        this.status,
        this.dateCreated});

  SpecialCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    resturants = json['resturants'];
    displayOrder = json['display_order'];
    visibility = json['visibility'];
    status = json['status'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['resturants'] = this.resturants;
    data['display_order'] = this.displayOrder;
    data['visibility'] = this.visibility;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
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