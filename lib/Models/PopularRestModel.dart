// To parse this JSON data, do
//
//     final popularRestModel = popularRestModelFromJson(jsonString);

import 'dart:convert';

PopularRestModel popularRestModelFromJson(String str) => PopularRestModel.fromJson(json.decode(str));

String popularRestModelToJson(PopularRestModel data) => json.encode(data.toJson());

class PopularRestModel {
  PopularRestModel({
    this.cuisines,
    this.reviewAvgRating,
    this.reviewCount,
    this.avgReview,
    this.cuisineName,
    this.merchantBranchId,
    this.merchantBranchStatus,
    this.merchantBranchBusyAddedTime,
    this.merchantBranchBusyEndTime,
    this.merchantBranchBusy,
    this.merchantBranchVisibility,
    this.merchantBranchDispalyOrder,
    this.merchantBranchMerchantId,
    this.merchantBranchCountry,
    this.merchantBranchCity,
    this.merchantBranchArea,
    this.merchantBranchName,
    this.merchantBranchTelephone,
    this.merchantBranchEmail,
    this.merchantBranchServeType,
    this.merchantBranchCuisine,
    this.merchantBranchDeliveryType,
    this.merchantBranchMinOrderAmnt,
    this.merchantBranchMinWalletAmnt,
    this.merchantBranchPaymnetMode,
    this.merchantBranchImage,
    this.merchantBranchOrderTime,
    this.merchantBranchTaxOn,
    this.merchantBranchTaxPercentage,
    this.merchantBranchTokenAmount,
    this.merchantBranchWallet,
    this.merchantBranchContactName,
    this.merchantBranchPhoneNumber,
    this.merchantBranchBankName,
    this.merchantBranchAccountNumber,
    this.merchantBranchBankBranch,
    this.merchantBranchIfscCode,
    this.merchantBranchAddress,
    this.merchantBranchBusyReason,
    this.merchantBranchModifiedby,
    this.merchantBranchAddedDate,
    this.merchantBranchApprovedDate,
    this.merchantBranchDeleteStatus,
    this.lat,
    this.lng,
    this.merchantBranchStat,
    this.merchantPackChargeType,
    this.merchantPackCharge,
    this.distance,
    this.merchantBranchCoverImage,
    this.rating
  });

  String? cuisines;
  dynamic? reviewAvgRating;
  String? rating;
  String? reviewCount;
  String? avgReview;
  String? cuisineName;
  String? merchantBranchStatus;
  String? merchantBranchId;
  DateTime? merchantBranchBusyAddedTime;
  DateTime? merchantBranchBusyEndTime;
  String? merchantBranchBusy;
  String? merchantBranchVisibility;
  String? merchantBranchDispalyOrder;
  String? merchantBranchMerchantId;
  String? merchantBranchCountry;
  String? merchantBranchCity;
  String? merchantBranchArea;
  String? merchantBranchName;
  String? merchantBranchTelephone;
  String? merchantBranchEmail;
  String? merchantBranchServeType;
  String? merchantBranchCuisine;
  String? merchantBranchDeliveryType;
  String? merchantBranchMinOrderAmnt;
  String? merchantBranchMinWalletAmnt;
  String? merchantBranchPaymnetMode;
  String? merchantBranchImage;
  String? merchantBranchCoverImage;
  String? merchantBranchOrderTime;
  String? merchantBranchTaxOn;
  String? merchantBranchTaxPercentage;
  String? merchantBranchTokenAmount;
  String? merchantBranchWallet;
  String? merchantBranchContactName;
  String? merchantBranchPhoneNumber;
  String? merchantBranchBankName;
  String? merchantBranchAccountNumber;
  String? merchantBranchBankBranch;
  String? merchantBranchIfscCode;
  String? merchantBranchAddress;
  String? merchantBranchBusyReason;
  String? merchantBranchModifiedby;
  DateTime? merchantBranchAddedDate;
  DateTime? merchantBranchApprovedDate;
  String? merchantBranchDeleteStatus;
  String? lat;
  String? lng;
  String? merchantBranchStat;
  String? merchantPackChargeType;
  String? merchantPackCharge;
  String? distance;


  factory PopularRestModel.fromJson(Map<String, dynamic> json) => PopularRestModel(
    cuisines: json["cuisines"] == null ? null : json["cuisines"],
    reviewAvgRating: json["review_avg_rating"],
    reviewCount: json["review_count"] == null ? null : json["review_count"],
    rating: json["rating"] == null ? null : json["rating"],
    avgReview: json["avg_review"] == null ? null : json["avg_review"],
    cuisineName: json["cuisine_name"] == null ? null : json["cuisine_name"],
    merchantBranchId: json["merchant_branch_id"] == null ? null : json["merchant_branch_id"],
    merchantBranchStatus: json["merchant_branch_status"] == null ? null : json["merchant_branch_status"],
    merchantBranchBusyAddedTime: json["merchant_branch_busy_added_time"] == null ? null : DateTime.parse(json["merchant_branch_busy_added_time"]),
    merchantBranchBusyEndTime: json["merchant_branch_busy_end_time"] == null ? null : DateTime.parse(json["merchant_branch_busy_end_time"]),
    merchantBranchBusy: json["merchant_branch_busy"] == null ? null : json["merchant_branch_busy"],
    merchantBranchVisibility: json["merchant_branch_visibility"] == null ? null : json["merchant_branch_visibility"],
    merchantBranchDispalyOrder: json["merchant_branch_dispaly_order"] == null ? null : json["merchant_branch_dispaly_order"],
    merchantBranchMerchantId: json["merchant_branch_merchant_id"] == null ? null : json["merchant_branch_merchant_id"],
    merchantBranchCountry: json["merchant_branch_country"] == null ? null : json["merchant_branch_country"],
    merchantBranchCity: json["merchant_branch_city"] == null ? null : json["merchant_branch_city"],
    merchantBranchArea: json["merchant_branch_area"] == null ? null : json["merchant_branch_area"],
    merchantBranchName: json["merchant_branch_name"] == null ? null : json["merchant_branch_name"],
    merchantBranchTelephone: json["merchant_branch_telephone"] == null ? null : json["merchant_branch_telephone"],
    merchantBranchEmail: json["merchant_branch_email"] == null ? null : json["merchant_branch_email"],
    merchantBranchServeType: json["merchant_branch_serve_type"] == null ? null : json["merchant_branch_serve_type"],
    merchantBranchCuisine: json["merchant_branch_cuisine"] == null ? null : json["merchant_branch_cuisine"],
    merchantBranchDeliveryType: json["merchant_branch_delivery_type"] == null ? null : json["merchant_branch_delivery_type"],
    merchantBranchMinOrderAmnt: json["merchant_branch_min_order_amnt"] == null ? null : json["merchant_branch_min_order_amnt"],
    merchantBranchMinWalletAmnt: json["merchant_branch_min_wallet_amnt"] == null ? null : json["merchant_branch_min_wallet_amnt"],
    merchantBranchPaymnetMode: json["merchant_branch_paymnet_mode"] == null ? null : json["merchant_branch_paymnet_mode"],
    merchantBranchImage: json["merchant_branch_image"] == null ? null : json["merchant_branch_image"],
    merchantBranchCoverImage: json["merchant_branch_cover_image"] == null ? null : json["merchant_branch_cover_image"],
    merchantBranchOrderTime: json["merchant_branch_order_time"] == null ? null : json["merchant_branch_order_time"],
    merchantBranchTaxOn: json["merchant_branch_tax_on"] == null ? null : json["merchant_branch_tax_on"],
    merchantBranchTaxPercentage: json["merchant_branch_tax_percentage"] == null ? null : json["merchant_branch_tax_percentage"],
    merchantBranchTokenAmount: json["merchant_branch_token_amount"] == null ? null : json["merchant_branch_token_amount"],
    merchantBranchWallet: json["merchant_branch_wallet"] == null ? null : json["merchant_branch_wallet"],
    merchantBranchContactName: json["merchant_branch_contact_name"] == null ? null : json["merchant_branch_contact_name"],
    merchantBranchPhoneNumber: json["merchant_branch_phone_number"] == null ? null : json["merchant_branch_phone_number"],
    merchantBranchBankName: json["merchant_branch_bank_name"] == null ? null : json["merchant_branch_bank_name"],
    merchantBranchAccountNumber: json["merchant_branch_account_number"] == null ? null : json["merchant_branch_account_number"],
    merchantBranchBankBranch: json["merchant_branch_bank_branch"] == null ? null : json["merchant_branch_bank_branch"],
    merchantBranchIfscCode: json["merchant_branch_ifsc_code"] == null ? null : json["merchant_branch_ifsc_code"],
    merchantBranchAddress: json["merchant_branch_address"] == null ? null : json["merchant_branch_address"],
    merchantBranchBusyReason: json["merchant_branch_busy_reason"] == null ? null : json["merchant_branch_busy_reason"],
    merchantBranchModifiedby: json["merchant_branch_modifiedby"] == null ? null : json["merchant_branch_modifiedby"],
    merchantBranchAddedDate: json["merchant_branch_added_date"] == null ? null : DateTime.parse(json["merchant_branch_added_date"]),
    merchantBranchApprovedDate: json["merchant_branch_approved_date"] == null ? null : DateTime.parse(json["merchant_branch_approved_date"]),
    merchantBranchDeleteStatus: json["merchant_branch_delete_status"] == null ? null : json["merchant_branch_delete_status"],
    lat: json["lat"] == null ? null : json["lat"],
    lng: json["lng"] == null ? null : json["lng"],
    merchantBranchStat: json["merchant_branch_stat"] == null ? null : json["merchant_branch_stat"],
    merchantPackChargeType: json["merchant_pack_charge_type"] == null ? null : json["merchant_pack_charge_type"],
    merchantPackCharge: json["merchant_pack_charge"] == null ? null : json["merchant_pack_charge"],
    distance: json["distance"] == null ? null : json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "cuisines": cuisines == null ? null : cuisines,
    "review_avg_rating": reviewAvgRating,
    "review_count": reviewCount == null ? null : reviewCount,
    "rating": rating == null ? null : rating,
    "avg_review": avgReview == null ? null : avgReview,
    "cuisine_name": cuisineName == null ? null : cuisineName,
    "merchant_branch_id": merchantBranchId == null ? null : merchantBranchId,
    "merchant_branch_status": merchantBranchStatus == null ? null : merchantBranchStatus,
    "merchant_branch_busy_added_time": merchantBranchBusyAddedTime == null ? null : merchantBranchBusyAddedTime,
    "merchant_branch_busy_end_time": merchantBranchBusyEndTime == null ? null : merchantBranchBusyEndTime,
    "merchant_branch_busy": merchantBranchBusy == null ? null : merchantBranchBusy,
    "merchant_branch_visibility": merchantBranchVisibility == null ? null : merchantBranchVisibility,
    "merchant_branch_dispaly_order": merchantBranchDispalyOrder == null ? null : merchantBranchDispalyOrder,
    "merchant_branch_merchant_id": merchantBranchMerchantId == null ? null : merchantBranchMerchantId,
    "merchant_branch_country": merchantBranchCountry == null ? null : merchantBranchCountry,
    "merchant_branch_city": merchantBranchCity == null ? null : merchantBranchCity,
    "merchant_branch_area": merchantBranchArea == null ? null : merchantBranchArea,
    "merchant_branch_name": merchantBranchName == null ? null : merchantBranchName,
    "merchant_branch_telephone": merchantBranchTelephone == null ? null : merchantBranchTelephone,
    "merchant_branch_email": merchantBranchEmail == null ? null : merchantBranchEmail,
    "merchant_branch_serve_type": merchantBranchServeType == null ? null : merchantBranchServeType,
    "merchant_branch_cuisine": merchantBranchCuisine == null ? null : merchantBranchCuisine,
    "merchant_branch_delivery_type": merchantBranchDeliveryType == null ? null : merchantBranchDeliveryType,
    "merchant_branch_min_order_amnt": merchantBranchMinOrderAmnt == null ? null : merchantBranchMinOrderAmnt,
    "merchant_branch_min_wallet_amnt": merchantBranchMinWalletAmnt == null ? null : merchantBranchMinWalletAmnt,
    "merchant_branch_paymnet_mode": merchantBranchPaymnetMode == null ? null : merchantBranchPaymnetMode,
    "merchant_branch_image": merchantBranchImage == null ? null : merchantBranchImage,
    "merchant_branch_cover_image" : merchantBranchCoverImage == null ? null : merchantBranchCoverImage,
    "merchant_branch_order_time": merchantBranchOrderTime == null ? null : merchantBranchOrderTime,
    "merchant_branch_tax_on": merchantBranchTaxOn == null ? null : merchantBranchTaxOn,
    "merchant_branch_tax_percentage": merchantBranchTaxPercentage == null ? null : merchantBranchTaxPercentage,
    "merchant_branch_token_amount": merchantBranchTokenAmount == null ? null : merchantBranchTokenAmount,
    "merchant_branch_wallet": merchantBranchWallet == null ? null : merchantBranchWallet,
    "merchant_branch_contact_name": merchantBranchContactName == null ? null : merchantBranchContactName,
    "merchant_branch_phone_number": merchantBranchPhoneNumber == null ? null : merchantBranchPhoneNumber,
    "merchant_branch_bank_name": merchantBranchBankName == null ? null : merchantBranchBankName,
    "merchant_branch_account_number": merchantBranchAccountNumber == null ? null : merchantBranchAccountNumber,
    "merchant_branch_bank_branch": merchantBranchBankBranch == null ? null : merchantBranchBankBranch,
    "merchant_branch_ifsc_code": merchantBranchIfscCode == null ? null : merchantBranchIfscCode,
    "merchant_branch_address": merchantBranchAddress == null ? null : merchantBranchAddress,
    "merchant_branch_busy_reason": merchantBranchBusyReason == null ? null : merchantBranchBusyReason,
    "merchant_branch_modifiedby": merchantBranchModifiedby == null ? null : merchantBranchModifiedby,
    "merchant_branch_added_date": merchantBranchAddedDate == null ? null : merchantBranchAddedDate,
    "merchant_branch_approved_date": merchantBranchApprovedDate == null ? null : merchantBranchApprovedDate,
    "merchant_branch_delete_status": merchantBranchDeleteStatus == null ? null : merchantBranchDeleteStatus,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "merchant_branch_stat": merchantBranchStat == null ? null : merchantBranchStat,
    "merchant_pack_charge_type": merchantPackChargeType == null ? null : merchantPackChargeType,
    "merchant_pack_charge": merchantPackCharge == null ? null : merchantPackCharge,
    "distance": distance == null ? null : distance,
  };
}
