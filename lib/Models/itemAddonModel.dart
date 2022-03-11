// To parse this JSON data, do
//
//     final itemAddonModel = itemAddonModelFromJson(jsonString);

import 'dart:convert';

ItemAddonModel itemAddonModelFromJson(String str) => ItemAddonModel.fromJson(json.decode(str));

String itemAddonModelToJson(ItemAddonModel data) => json.encode(data.toJson());

class ItemAddonModel {
  ItemAddonModel({
    this.addons,
  });

  List<AddonModel>? addons;

  factory ItemAddonModel.fromJson(Map<String, dynamic> json) => ItemAddonModel(
    addons: json["addons"] == null ? null : List<AddonModel>.from(json["addons"].map((x) => AddonModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "addons": addons == null ? null : List<dynamic>.from(addons!.map((x) => x.toJson())),
  };
}

class AddonModel {
  AddonModel({
    this.itemAddonsTitleDisplayOrder,
    this.itemAddonsTitleTblid,
    this.itemAddonsTitleAddonsId,
    this.itemAddonsTitleCount,
    this.itemAddonsTitleType,
    this.itemAddonsTitleItemId,
    this.itemAddonsSubtitleTblid,
    this.itemAddonsSubtitleSubtitleId,
    this.addonsName,
    this.addonsType,
    this.addonsArabi,
    this.addonsSubTitleName,
    this.addonsSubTitleArabi,
    this.addonsSubTitlePrice,
    this.displayOrder,
    this.isSelected,
  });

  String? itemAddonsTitleDisplayOrder;
  String? itemAddonsTitleTblid;
  String? itemAddonsTitleAddonsId;
  String? itemAddonsTitleCount;
  String? itemAddonsTitleType;
  String? itemAddonsTitleItemId;
  String? itemAddonsSubtitleTblid;
  String? itemAddonsSubtitleSubtitleId;
  String? addonsName;
  String? addonsType;
  String? addonsArabi;
  String? addonsSubTitleName;
  String? addonsSubTitleArabi;
  String? addonsSubTitlePrice;
  dynamic displayOrder;
  bool? isSelected;

  factory AddonModel.fromJson(Map<String, dynamic> json) => AddonModel(
    itemAddonsTitleDisplayOrder: json["item_addons_title_display_order"] == null ? null : json["item_addons_title_display_order"],
    itemAddonsTitleTblid: json["item_addons_title_tblid"] == null ? null : json["item_addons_title_tblid"],
    itemAddonsTitleAddonsId: json["item_addons_title_addons_id"] == null ? null : json["item_addons_title_addons_id"],
    itemAddonsTitleCount: json["item_addons_title_count"] == null ? null : json["item_addons_title_count"],
    itemAddonsTitleType: json["item_addons_title_type"] == null ? null : json["item_addons_title_type"],
    itemAddonsTitleItemId: json["item_addons_title_item_id"] == null ? null : json["item_addons_title_item_id"],
    itemAddonsSubtitleTblid: json["item_addons_subtitle_tblid"] == null ? null : json["item_addons_subtitle_tblid"],
    itemAddonsSubtitleSubtitleId: json["item_addons_subtitle_subtitle_id"] == null ? null : json["item_addons_subtitle_subtitle_id"],
    addonsName: json["addons_name"] == null ? null : json["addons_name"],
    addonsType: json["addons_type"] == null ? null : json["addons_type"],
    addonsArabi: json["addons_arabi"] == null ? null : json["addons_arabi"],
    addonsSubTitleName: json["addons_sub_title_name"] == null ? null : json["addons_sub_title_name"],
    addonsSubTitleArabi: json["addons_sub_title_arabi"] == null ? null : json["addons_sub_title_arabi"],
    addonsSubTitlePrice: json["addons_sub_title_price"] == null ? null : json["addons_sub_title_price"],
    displayOrder: json["display_order"],
  );

  Map<String, dynamic> toJson() => {
    "item_addons_title_display_order": itemAddonsTitleDisplayOrder == null ? null : itemAddonsTitleDisplayOrder,
    "item_addons_title_tblid": itemAddonsTitleTblid == null ? null : itemAddonsTitleTblid,
    "item_addons_title_addons_id": itemAddonsTitleAddonsId == null ? null : itemAddonsTitleAddonsId,
    "item_addons_title_count": itemAddonsTitleCount == null ? null : itemAddonsTitleCount,
    "item_addons_title_type": itemAddonsTitleType == null ? null : itemAddonsTitleType,
    "item_addons_title_item_id": itemAddonsTitleItemId == null ? null : itemAddonsTitleItemId,
    "item_addons_subtitle_tblid": itemAddonsSubtitleTblid == null ? null : itemAddonsSubtitleTblid,
    "item_addons_subtitle_subtitle_id": itemAddonsSubtitleSubtitleId == null ? null : itemAddonsSubtitleSubtitleId,
    "addons_name": addonsName == null ? null :addonsName,
    "addons_type": addonsType == null ? null : addonsType,
    "addons_arabi": addonsArabi == null ? null : addonsArabi,
    "addons_sub_title_name": addonsSubTitleName == null ? null : addonsSubTitleName,
    "addons_sub_title_arabi": addonsSubTitleArabi == null ? null : addonsSubTitleArabi,
    "addons_sub_title_price": addonsSubTitlePrice == null ? null : addonsSubTitlePrice,
    "display_order": displayOrder,
  };
}


