// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    this.sliderId,
    this.sliderStatus,
    this.sliderType,
    this.sliderDisplayOrder,
    this.sliderMerchantId,
    this.sliderImage,
    this.sliderDays,
    this.sliderStartDate,
    this.sliderEndDate,
    this.sliderAddedDate,
    this.sliderAddedBy,
    this.sliderAddedByType,
    this.sliderModifiedBy,
    this.sliderModifiedDate,
    this.sliderModifiedType,
    this.distance,
  });

  String? sliderId;
  String? sliderStatus;
  String? sliderType;
  String? sliderDisplayOrder;
  String? sliderMerchantId;
  String? sliderImage;
  String? sliderDays;
  DateTime? sliderStartDate;
  DateTime? sliderEndDate;
  DateTime? sliderAddedDate;
  String? sliderAddedBy;
  String? sliderAddedByType;
  String? sliderModifiedBy;
  DateTime? sliderModifiedDate;
  String? sliderModifiedType;
  String? distance;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    sliderId: json["slider_id"] == null ? null : json["slider_id"],
    sliderStatus: json["slider_status"] == null ? null : json["slider_status"],
    sliderType: json["slider_type"] == null ? null : json["slider_type"],
    sliderDisplayOrder: json["slider_display_order"] == null ? null : json["slider_display_order"],
    sliderMerchantId: json["slider_merchant_id"] == null ? null : json["slider_merchant_id"],
    sliderImage: json["slider_image"] == null ? null : json["slider_image"],
    sliderDays: json["slider_days"] == null ? null : json["slider_days"],
    sliderStartDate: json["slider_start_date"] == null ? null : DateTime.parse(json["slider_start_date"]),
    sliderEndDate: json["slider_end_date"] == null ? null : DateTime.parse(json["slider_end_date"]),
    sliderAddedDate: json["slider_added_date"] == null ? null : DateTime.parse(json["slider_added_date"]),
    sliderAddedBy: json["slider_added_by"] == null ? null : json["slider_added_by"],
    sliderAddedByType: json["slider_added_by_type"] == null ? null : json["slider_added_by_type"],
    sliderModifiedBy: json["slider_modified_by"] == null ? null : json["slider_modified_by"],
    sliderModifiedDate: json["slider_modified_date"] == null ? null : DateTime.parse(json["slider_modified_date"]),
    sliderModifiedType: json["slider_modified_type"] == null ? null : json["slider_modified_type"],
    distance: json["distance"] == null ? null : json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "slider_id": sliderId == null ? null : sliderId,
    "slider_status": sliderStatus == null ? null : sliderStatus,
    "slider_type": sliderType == null ? null : sliderType,
    "slider_display_order": sliderDisplayOrder == null ? null : sliderDisplayOrder,
    "slider_merchant_id": sliderMerchantId == null ? null : sliderMerchantId,
    "slider_image": sliderImage == null ? null : sliderImage,
    "slider_days": sliderDays == null ? null : sliderDays,
    "slider_start_date": sliderStartDate == null ? null : sliderStartDate,
    "slider_end_date": sliderEndDate == null ? null : sliderEndDate,
    "slider_added_date": sliderAddedDate == null ? null : sliderAddedDate,
    "slider_added_by": sliderAddedBy == null ? null : sliderAddedBy,
    "slider_added_by_type": sliderAddedByType == null ? null : sliderAddedByType,
    "slider_modified_by": sliderModifiedBy == null ? null : sliderModifiedBy,
    "slider_modified_date": sliderModifiedDate == null ? null : sliderModifiedDate,
    "slider_modified_type": sliderModifiedType == null ? null : sliderModifiedType,
    "distance": distance == null ? null : distance,
  };
}
