
class RestaurentModel {
  int? errorCode;
  List<Results>? results;


  RestaurentModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class Results {
  String? cuisines;
  Null reviewAvgRating;
  String? reviewCount;
  String? avgReview;
  String? cuisineName;
  String? merchantBranchId;
  String? merchantBranchStatus;
  String? merchantBranchBusyAddedTime;
  String? merchantBranchBusyEndTime;
  String? merchantBranchBusy;
  String? merchantBranchVisibility;
  String? merchantBranchDispalyOrder;
  String? merchantBranchMerchantId;
  String? merchantBranchCountry;
  String? merchantBranchCity;
  String? merchantBranchArea;
  String? merchantBranchName;
  String? merchantBranchNameArabi;
  String? merchantBranchTelephone;
  String? merchantBranchAltPhone;
  String? merchantBranchEmail;
  String? merchantBranchDescriptionArabic;
  String? merchantBranchServeType;
  String? merchantBranchCuisine;
  String? merchantBranchDeliveryType;
  String? merchantBranchMinOrderAmnt;
  String? merchantBranchMinWalletAmnt;
  String? merchantBranchPaymnetMode;
  String? merchantBranchImage;
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
  String? merchantBranchAddedDate;
  String? merchantBranchApprovedDate;
  String? merchantBranchDeleteStatus;
  String? lat;
  String? lng;
  String? merchantBranchStat;
  String? merchantPackChargeType;
  String? merchantPackCharge;
  String? distance;
  String? openStatus;
  OfferTag? offerTag;

  Results(
      {this.cuisines,
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
        this.merchantBranchNameArabi,
        this.merchantBranchTelephone,
        this.merchantBranchAltPhone,
        this.merchantBranchEmail,
        this.merchantBranchDescriptionArabic,
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
        this.openStatus,
        this.offerTag});

  Results.fromJson(Map<String, dynamic> json) {
    cuisines = json['cuisines'];
    reviewAvgRating = json['review_avg_rating'];
    reviewCount = json['review_count'];
    avgReview = json['avg_review'];
    cuisineName = json['cuisine_name'];
    merchantBranchId = json['merchant_branch_id'];
    merchantBranchStatus = json['merchant_branch_status'];
    merchantBranchBusyAddedTime = json['merchant_branch_busy_added_time'];
    merchantBranchBusyEndTime = json['merchant_branch_busy_end_time'];
    merchantBranchBusy = json['merchant_branch_busy'];
    merchantBranchVisibility = json['merchant_branch_visibility'];
    merchantBranchDispalyOrder = json['merchant_branch_dispaly_order'];
    merchantBranchMerchantId = json['merchant_branch_merchant_id'];
    merchantBranchCountry = json['merchant_branch_country'];
    merchantBranchCity = json['merchant_branch_city'];
    merchantBranchArea = json['merchant_branch_area'];
    merchantBranchName = json['merchant_branch_name'];
    merchantBranchNameArabi = json['merchant_branch_name_arabi'];
    merchantBranchTelephone = json['merchant_branch_telephone'];
    merchantBranchAltPhone = json['merchant_branch_alt_phone'];
    merchantBranchEmail = json['merchant_branch_email'];
    merchantBranchDescriptionArabic =
    json['merchant_branch_description_arabic'];
    merchantBranchServeType = json['merchant_branch_serve_type'];
    merchantBranchCuisine = json['merchant_branch_cuisine'];
    merchantBranchDeliveryType = json['merchant_branch_delivery_type'];
    merchantBranchMinOrderAmnt = json['merchant_branch_min_order_amnt'];
    merchantBranchMinWalletAmnt = json['merchant_branch_min_wallet_amnt'];
    merchantBranchPaymnetMode = json['merchant_branch_paymnet_mode'];
    merchantBranchImage = json['merchant_branch_image'];
    merchantBranchOrderTime = json['merchant_branch_order_time'];
    merchantBranchTaxOn = json['merchant_branch_tax_on'];
    merchantBranchTaxPercentage = json['merchant_branch_tax_percentage'];
    merchantBranchTokenAmount = json['merchant_branch_token_amount'];
    merchantBranchWallet = json['merchant_branch_wallet'];
    merchantBranchContactName = json['merchant_branch_contact_name'];
    merchantBranchPhoneNumber = json['merchant_branch_phone_number'];
    merchantBranchBankName = json['merchant_branch_bank_name'];
    merchantBranchAccountNumber = json['merchant_branch_account_number'];
    merchantBranchBankBranch = json['merchant_branch_bank_branch'];
    merchantBranchIfscCode = json['merchant_branch_ifsc_code'];
    merchantBranchAddress = json['merchant_branch_address'];
    merchantBranchBusyReason = json['merchant_branch_busy_reason'];
    merchantBranchModifiedby = json['merchant_branch_modifiedby'];
    merchantBranchAddedDate = json['merchant_branch_added_date'];
    merchantBranchApprovedDate = json['merchant_branch_approved_date'];
    merchantBranchDeleteStatus = json['merchant_branch_delete_status'];
    lat = json['lat'];
    lng = json['lng'];
    merchantBranchStat = json['merchant_branch_stat'];
    merchantPackChargeType = json['merchant_pack_charge_type'];
    merchantPackCharge = json['merchant_pack_charge'];
    distance = json['distance'];
    openStatus = json['open_status'];
    offerTag = json['offer_tag'] != null
        ? new OfferTag.fromJson(json['offer_tag'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuisines'] = this.cuisines;
    data['review_avg_rating'] = this.reviewAvgRating;
    data['review_count'] = this.reviewCount;
    data['avg_review'] = this.avgReview;
    data['cuisine_name'] = this.cuisineName;
    data['merchant_branch_id'] = this.merchantBranchId;
    data['merchant_branch_status'] = this.merchantBranchStatus;
    data['merchant_branch_busy_added_time'] = this.merchantBranchBusyAddedTime;
    data['merchant_branch_busy_end_time'] = this.merchantBranchBusyEndTime;
    data['merchant_branch_busy'] = this.merchantBranchBusy;
    data['merchant_branch_visibility'] = this.merchantBranchVisibility;
    data['merchant_branch_dispaly_order'] = this.merchantBranchDispalyOrder;
    data['merchant_branch_merchant_id'] = this.merchantBranchMerchantId;
    data['merchant_branch_country'] = this.merchantBranchCountry;
    data['merchant_branch_city'] = this.merchantBranchCity;
    data['merchant_branch_area'] = this.merchantBranchArea;
    data['merchant_branch_name'] = this.merchantBranchName;
    data['merchant_branch_name_arabi'] = this.merchantBranchNameArabi;
    data['merchant_branch_telephone'] = this.merchantBranchTelephone;
    data['merchant_branch_alt_phone'] = this.merchantBranchAltPhone;
    data['merchant_branch_email'] = this.merchantBranchEmail;
    data['merchant_branch_description_arabic'] =
        this.merchantBranchDescriptionArabic;
    data['merchant_branch_serve_type'] = this.merchantBranchServeType;
    data['merchant_branch_cuisine'] = this.merchantBranchCuisine;
    data['merchant_branch_delivery_type'] = this.merchantBranchDeliveryType;
    data['merchant_branch_min_order_amnt'] = this.merchantBranchMinOrderAmnt;
    data['merchant_branch_min_wallet_amnt'] = this.merchantBranchMinWalletAmnt;
    data['merchant_branch_paymnet_mode'] = this.merchantBranchPaymnetMode;
    data['merchant_branch_image'] = this.merchantBranchImage;
    data['merchant_branch_order_time'] = this.merchantBranchOrderTime;
    data['merchant_branch_tax_on'] = this.merchantBranchTaxOn;
    data['merchant_branch_tax_percentage'] = this.merchantBranchTaxPercentage;
    data['merchant_branch_token_amount'] = this.merchantBranchTokenAmount;
    data['merchant_branch_wallet'] = this.merchantBranchWallet;
    data['merchant_branch_contact_name'] = this.merchantBranchContactName;
    data['merchant_branch_phone_number'] = this.merchantBranchPhoneNumber;
    data['merchant_branch_bank_name'] = this.merchantBranchBankName;
    data['merchant_branch_account_number'] = this.merchantBranchAccountNumber;
    data['merchant_branch_bank_branch'] = this.merchantBranchBankBranch;
    data['merchant_branch_ifsc_code'] = this.merchantBranchIfscCode;
    data['merchant_branch_address'] = this.merchantBranchAddress;
    data['merchant_branch_busy_reason'] = this.merchantBranchBusyReason;
    data['merchant_branch_modifiedby'] = this.merchantBranchModifiedby;
    data['merchant_branch_added_date'] = this.merchantBranchAddedDate;
    data['merchant_branch_approved_date'] = this.merchantBranchApprovedDate;
    data['merchant_branch_delete_status'] = this.merchantBranchDeleteStatus;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['merchant_branch_stat'] = this.merchantBranchStat;
    data['merchant_pack_charge_type'] = this.merchantPackChargeType;
    data['merchant_pack_charge'] = this.merchantPackCharge;
    data['distance'] = this.distance;
    data['open_status'] = this.openStatus;
    if (this.offerTag != null) {
      data['offer_tag'] = this.offerTag!.toJson();
    }
    return data;
  }
}

class OfferTag {
  String? couponTag;
  String? promoTag;

  OfferTag({this.couponTag, this.promoTag});

  OfferTag.fromJson(Map<String, dynamic> json) {
    couponTag = json['coupon_tag'];
    promoTag = json['promo_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_tag'] = this.couponTag;
    data['promo_tag'] = this.promoTag;
    return data;
  }
}
