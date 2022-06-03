

class CuisinesModel {
  String? cuisineId;
  String? cuisineName;
  String? cuisineNameArabic;
  String? cuisineVisibility;
  String? cuisineDisplayOrder;
  String? cuisineAddedDate;
  String? cusineModifiedOn;
  String? cuisineDeleteStatus;
  String? displayOrder;
  bool? isChecked;

  CuisinesModel(
      {this.cuisineId,
        this.cuisineName,
        this.cuisineNameArabic,
        this.cuisineVisibility,
        this.cuisineDisplayOrder,
        this.cuisineAddedDate,
        this.cusineModifiedOn,
        this.cuisineDeleteStatus,
        this.displayOrder,
      this.isChecked});

  CuisinesModel.fromJson(Map<String, dynamic> json) {
    cuisineId = json['cuisine_id'];
    cuisineName = json['cuisine_name'];
    cuisineNameArabic = json['cuisine_name_arabic'];
    cuisineVisibility = json['cuisine_visibility'];
    cuisineDisplayOrder = json['cuisine_display_order'];
    cuisineAddedDate = json['cuisine_added_date'];
    cusineModifiedOn = json['cusine_modified_on'];
    cuisineDeleteStatus = json['cuisine_delete_status'];
    displayOrder = json['display_order'];
    isChecked = false;
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