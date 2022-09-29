class OfferModel {
  List<CouponList>? couponList;

  OfferModel({this.couponList});

  OfferModel.fromJson(Map<String, dynamic> json) {
    if (json['coupon_list'] != null) {
      couponList = <CouponList>[];
      json['coupon_list'].forEach((v) {
        couponList!.add(new CouponList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.couponList != null) {
      data['coupon_list'] = this.couponList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponList {
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

  CouponList(
      {this.couponId,
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
        this.merchantBranchName});

  CouponList.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    couponDeleteStatus = json['coupon_delete_status'];
    couponTitle = json['coupon_title'];
    couponCode = json['coupon_code'];
    couponLimit = json['coupon_limit'];
    couponMaxDiscountAmount = json['coupon_max_discount_amount'];
    couponOfferType = json['coupon_offer_type'];
    couponPriceType = json['coupon_price_type'];
    couponPrice = json['coupon_price'];
    couponDescription = json['coupon_description'];
    couponMerchant = json['coupon_merchant'];
    couponBranch = json['coupon_branch'];
    couponType = json['coupon_type'];
    couponMinimumAmount = json['coupon_minimum_amount'];
    couponStartDate = json['coupon_start_date'];
    couponEndDate = json['coupon_end_date'];
    couponApplicableTime = json['coupon_applicable_time'];
    couponApplicableStartTime = json['coupon_applicable_start_time'];
    couponApplicableEndTime = json['coupon_applicable_end_time'];
    couponAddedTime = json['coupon_added_time'];
    couponFirstDealStatus = json['coupon_first_deal_status'];
    couponAddedBy = json['coupon_added_by'];
    couponCountry = json['coupon_country'];
    couponCity = json['coupon_city'];
    couponFullDiscountAmount = json['coupon_full_discount_amount'];
    merchantName = json['merchant_name'];
    merchantId = json['merchant_id'];
    merchantBranchId = json['merchant_branch_id'];
    merchantBranchName = json['merchant_branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['coupon_delete_status'] = this.couponDeleteStatus;
    data['coupon_title'] = this.couponTitle;
    data['coupon_code'] = this.couponCode;
    data['coupon_limit'] = this.couponLimit;
    data['coupon_max_discount_amount'] = this.couponMaxDiscountAmount;
    data['coupon_offer_type'] = this.couponOfferType;
    data['coupon_price_type'] = this.couponPriceType;
    data['coupon_price'] = this.couponPrice;
    data['coupon_description'] = this.couponDescription;
    data['coupon_merchant'] = this.couponMerchant;
    data['coupon_branch'] = this.couponBranch;
    data['coupon_type'] = this.couponType;
    data['coupon_minimum_amount'] = this.couponMinimumAmount;
    data['coupon_start_date'] = this.couponStartDate;
    data['coupon_end_date'] = this.couponEndDate;
    data['coupon_applicable_time'] = this.couponApplicableTime;
    data['coupon_applicable_start_time'] = this.couponApplicableStartTime;
    data['coupon_applicable_end_time'] = this.couponApplicableEndTime;
    data['coupon_added_time'] = this.couponAddedTime;
    data['coupon_first_deal_status'] = this.couponFirstDealStatus;
    data['coupon_added_by'] = this.couponAddedBy;
    data['coupon_country'] = this.couponCountry;
    data['coupon_city'] = this.couponCity;
    data['coupon_full_discount_amount'] = this.couponFullDiscountAmount;
    data['merchant_name'] = this.merchantName;
    data['merchant_id'] = this.merchantId;
    data['merchant_branch_id'] = this.merchantBranchId;
    data['merchant_branch_name'] = this.merchantBranchName;
    return data;
  }
}