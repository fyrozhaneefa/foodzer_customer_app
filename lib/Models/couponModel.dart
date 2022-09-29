// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

CouponModelList offerModelFromJson(String str) => CouponModelList.fromJson(json.decode(str));

String offerModelToJson(CouponModelList data) => json.encode(data.toJson());

// class OfferCouponModel {
//   OfferCouponModel({
//     this.couponList,
//   });
//
//   List<CouponList>? couponList;
//
//   factory OfferCouponModel.fromJson(Map<String, dynamic> json) => OfferCouponModel(
//     couponList: List<CouponList>.from(json["coupon_list"].map((x) => CouponList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "coupon_list": List<dynamic>.from(couponList!.map((x) => x.toJson())),
//   };
// }

class CouponModelList {
  CouponModelList({
    this.couponId,
    this.couponDeleteStatus,
    this.couponTitle,
    this.couponCode,
    this.couponLimit,
    this.couponMaxDiscountAmount,
    this.couponOfferType,
    this.couponPriceType,
    this.couponPrice,
    this.couponDescription,
    this.couponMerchant,
    this.couponBranch,
    this.couponType,
    this.couponMinimumAmount,
    this.couponStartDate,
    this.couponEndDate,
    this.couponApplicableTime,
    this.couponApplicableStartTime,
    this.couponApplicableEndTime,
    this.couponAddedTime,
    this.couponFirstDealStatus,
    this.couponAddedBy,
    this.couponCountry,
    this.couponCity,
    this.couponFullDiscountAmount,
    this.merchantName,
    this.merchantId,
    this.merchantBranchId,
    this.merchantBranchName,
    this.couponStatus
  });

  String? couponId;
  String? couponDeleteStatus;
  String? couponTitle;
  String? couponCode;
  String? couponLimit;
  String? couponMaxDiscountAmount;
  String? couponOfferType;
  String? couponPriceType;
  String? couponPrice;
  String? couponDescription;
  String? couponMerchant;
  String? couponBranch;
  String? couponType;
  String? couponMinimumAmount;
  String? couponStartDate;
  String? couponEndDate;
  String? couponApplicableTime;
  String? couponApplicableStartTime;
  String? couponApplicableEndTime;
  String? couponAddedTime;
  String? couponFirstDealStatus;
  String? couponAddedBy;
  String? couponCountry;
  String? couponCity;
  String? couponFullDiscountAmount;
  String? merchantName;
  String? merchantId;
  String? merchantBranchId;
  String? merchantBranchName;
  int? couponStatus;

  factory CouponModelList.fromJson(Map<String, dynamic> json) => CouponModelList(
    couponId: json["coupon_id"],
    couponDeleteStatus: json["coupon_delete_status"],
    couponTitle: json["coupon_title"],
    couponCode: json["coupon_code"],
    couponLimit: json["coupon_limit"],
    couponMaxDiscountAmount: json["coupon_max_discount_amount"],
    couponOfferType: json["coupon_offer_type"],
    couponPriceType: json["coupon_price_type"],
    couponPrice: json["coupon_price"],
    couponDescription: json["coupon_description"],
    couponMerchant: json["coupon_merchant"],
    couponBranch: json["coupon_branch"],
    couponType: json["coupon_type"],
    couponMinimumAmount: json["coupon_minimum_amount"],
    couponStartDate: json["coupon_start_date"],
    couponEndDate: json["coupon_end_date"],
    couponApplicableTime: json["coupon_applicable_time"],
    couponApplicableStartTime: json["coupon_applicable_start_time"],
    couponApplicableEndTime: json["coupon_applicable_end_time"],
    couponAddedTime: json["coupon_added_time"],
    couponFirstDealStatus: json["coupon_first_deal_status"],
    couponAddedBy: json["coupon_added_by"],
    couponCountry: json["coupon_country"],
    couponCity: json["coupon_city"],
    couponFullDiscountAmount: json["coupon_full_discount_amount"],
    merchantName: json["merchant_name"],
    merchantId: json["merchant_id"],
    merchantBranchId: json["merchant_branch_id"],
    merchantBranchName: json["merchant_branch_name"],
    couponStatus: null!=json["status"]?json["status"]:null,
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId,
    "coupon_delete_status": couponDeleteStatus,
    "coupon_title": couponTitle,
    "coupon_code": couponCode,
    "coupon_limit": couponLimit,
    "coupon_max_discount_amount": couponMaxDiscountAmount,
    "coupon_offer_type": couponOfferType,
    "coupon_price_type": couponPriceType,
    "coupon_price": couponPrice,
    "coupon_description": couponDescription,
    "coupon_merchant": couponMerchant,
    "coupon_branch": couponBranch,
    "coupon_type": couponType,
    "coupon_minimum_amount": couponMinimumAmount,
    "coupon_start_date": couponStartDate,
    "coupon_end_date": couponEndDate,
    "coupon_applicable_time": couponApplicableTime,
    "coupon_applicable_start_time": couponApplicableStartTime,
    "coupon_applicable_end_time": couponApplicableEndTime,
    "coupon_added_time": couponAddedTime,
    "coupon_first_deal_status": couponFirstDealStatus,
    "coupon_added_by": couponAddedBy,
    "coupon_country": couponCountry,
    "coupon_city": couponCity,
    "coupon_full_discount_amount": couponFullDiscountAmount,
    "merchant_name": merchantName,
    "merchant_id": merchantId,
    "merchant_branch_id": merchantBranchId,
    "merchant_branch_name": merchantBranchName,
    "status": couponStatus,
  };
}
