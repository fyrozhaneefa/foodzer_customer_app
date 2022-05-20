// To parse this JSON data, do
//
//     final priceOnItem = priceOnItemFromJson(jsonString);

import 'dart:convert';

PriceOnItem priceOnItemFromJson(String str) => PriceOnItem.fromJson(json.decode(str));

String priceOnItemToJson(PriceOnItem data) => json.encode(data.toJson());

class PriceOnItem {
  PriceOnItem({
    this.priceonId,
    this.priceonItemId,
    this.priceonItemBranch,
    this.priceonItemTitle,
    this.priceonItemPrice,
    this.priceonOfferItemPrice,
    this.priceonItemOfferAmt,
    this.priceonItemTitleAr,
    this.priceonCreatedon,
    this.priceonCretedby,
    this.isItemSelected
  });

  String? priceonId;
  String? priceonItemId;
  String? priceonItemBranch;
  String? priceonItemTitle;
  double? priceonItemPrice;
  String? priceonOfferItemPrice;
  String? priceonItemOfferAmt;
  String? priceonItemTitleAr;
  String? priceonCreatedon;
  String? priceonCretedby;
  bool? isItemSelected = false;

  factory PriceOnItem.fromJson(Map<String, dynamic> json) => PriceOnItem(
    priceonId: json["priceon_id"],
    priceonItemId: json["priceon_item_id"],
    priceonItemBranch: json["priceon_item_branch"],
    priceonItemTitle: json["priceon_item_title"],
    priceonItemPrice: null!=json["priceon_item_price"]? json["priceon_item_price"] is double ?
    json["priceon_item_price"] : double.parse(json["priceon_item_price"].toString()):0,
    priceonOfferItemPrice: json["priceon_offer_item_price"],
    priceonItemOfferAmt: json["priceon_item_offer_amt"],
    priceonItemTitleAr: json["priceon_item_title_ar"],
    priceonCreatedon: json["priceon_createdon"],
    priceonCretedby: json["priceon_cretedby"],
  );

  Map<String, dynamic> toJson() => {
    "priceon_id": priceonId,
    "priceon_item_id": priceonItemId,
    "priceon_item_branch": priceonItemBranch,
    "priceon_item_title": priceonItemTitle,
    "priceon_item_price": priceonItemPrice,
    "priceon_offer_item_price": priceonOfferItemPrice,
    "priceon_item_offer_amt": priceonItemOfferAmt,
    "priceon_item_title_ar": priceonItemTitleAr,
    "priceon_createdon": priceonCreatedon,
    "priceon_cretedby": priceonCretedby,
  };
}
