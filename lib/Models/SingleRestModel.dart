// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

SingleRestModel restaurantModelFromJson(String str) => SingleRestModel.fromJson(json.decode(str));

String restaurantModelToJson(SingleRestModel data) => json.encode(data.toJson());

class SingleRestModel {
  SingleRestModel({
    this.categories,
    this.offerDetails,
    this.timing,
    this.items,
    this.avgQuality,
    this.packageRating,
    this.deliveryRating,
    this.moneyRating,
    this.numOfRows,
    this.reviews,
    this.merchantBranchId,
    this.branchDetails,
    this.branchCuisine,
  });

  List<Category>? categories;
  List<dynamic>? offerDetails;
  Timing? timing;
  List<Item>? items;
  int? avgQuality;
  int? packageRating;
  int? deliveryRating;
  int? moneyRating;
  int? numOfRows;
  Reviews? reviews;
  String? merchantBranchId;
  BranchDetails? branchDetails;
  String? branchCuisine;

  factory SingleRestModel.fromJson(Map<String, dynamic> json) => SingleRestModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    offerDetails: List<dynamic>.from(json["offer_details"].map((x) => x)),
    timing: Timing.fromJson(json["timing"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    // items: List<List<Item>>.from(json["items"].map((x) => List<Item>.from(x.map((x) => Item.fromJson(x))))),
    avgQuality: json["avg_quality"],
    packageRating: json["package_rating"],
    deliveryRating: json["delivery_rating"],
    moneyRating: json["money_rating"],
    numOfRows: json["num_of_rows"],
    reviews: Reviews.fromJson(json["reviews"]),
    merchantBranchId: json["merchant_branch_id"],
    branchDetails: BranchDetails.fromJson(json["branch_details"]),
    branchCuisine: json["branch_cuisine"],
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "offer_details": List<dynamic>.from(offerDetails!.map((x) => x)),
    "timing": timing!.toJson(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "avg_quality": avgQuality,
    "package_rating": packageRating,
    "delivery_rating": deliveryRating,
    "money_rating": moneyRating,
    "num_of_rows": numOfRows,
    "reviews": reviews!.toJson(),
    "merchant_branch_id": merchantBranchId,
    "branch_details": branchDetails!.toJson(),
    "branch_cuisine": branchCuisine,
  };
}

class BranchDetails {
  BranchDetails({
    this.merchantBranchNameArabi,
    this.lat,
    this.lng,
    this.merchantBranchStat,
    this.merchantBranchVisibility,
    this.merchantBranchMinOrderAmnt,
    this.merchantBranchOrderTime,
    this.merchantBranchBusyAddedTime,
    this.merchantBranchBusyEndTime,
    this.merchantBranchId,
    this.merchantBranchAddress,
    this.merchantBranchName,
    this.merchantBranchBusy,
    this.merchantBranchPaymnetMode,
    this.merchantBranchImage,
    this.merchantPackCharge,
    this.merchantPackChargeType,
    this.countryCurrency,
    this.restaurantArea,
    this.distance,
    this.openStatus,
    this.merchantBranchPaymnetList,
  });

  String? merchantBranchNameArabi;
  String? lat;
  String? lng;
  String? merchantBranchStat;
  String? merchantBranchVisibility;
  String? merchantBranchMinOrderAmnt;
  String? merchantBranchOrderTime;
  dynamic merchantBranchBusyAddedTime;
  dynamic merchantBranchBusyEndTime;
  String? merchantBranchId;
  String? merchantBranchAddress;
  String? merchantBranchName;
  String? merchantBranchBusy;
  String? merchantBranchPaymnetMode;
  String? merchantBranchImage;
  String? merchantPackCharge;
  String? merchantPackChargeType;
  String? countryCurrency;
  String? restaurantArea;
  String? distance;
  String? openStatus;
  List<String>? merchantBranchPaymnetList;

  factory BranchDetails.fromJson(Map<String, dynamic> json) => BranchDetails(
    merchantBranchNameArabi: json["merchant_branch_name_arabi"],
    lat: json["lat"],
    lng: json["lng"],
    merchantBranchStat: json["merchant_branch_stat"],
    merchantBranchVisibility: json["merchant_branch_visibility"],
    merchantBranchMinOrderAmnt: json["merchant_branch_min_order_amnt"],
    merchantBranchOrderTime: json["merchant_branch_order_time"],
    merchantBranchBusyAddedTime: json["merchant_branch_busy_added_time"],
    merchantBranchBusyEndTime: json["merchant_branch_busy_end_time"],
    merchantBranchId: json["merchant_branch_id"],
    merchantBranchAddress: json["merchant_branch_address"],
    merchantBranchName: json["merchant_branch_name"],
    merchantBranchBusy: json["merchant_branch_busy"],
    merchantBranchPaymnetMode: json["merchant_branch_paymnet_mode"],
    merchantBranchImage: json["merchant_branch_image"],
    merchantPackCharge: json["merchant_pack_charge"],
    merchantPackChargeType: json["merchant_pack_charge_type"],
    countryCurrency: json["country_currency"],
    restaurantArea: json["restaurant_area"],
    distance: json["distance"],
    openStatus: json["open_status"],
    merchantBranchPaymnetList: List<String>.from(json["merchant_branch_paymnet_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "merchant_branch_name_arabi": merchantBranchNameArabi,
    "lat": lat,
    "lng": lng,
    "merchant_branch_stat": merchantBranchStat,
    "merchant_branch_visibility": merchantBranchVisibility,
    "merchant_branch_min_order_amnt": merchantBranchMinOrderAmnt,
    "merchant_branch_order_time": merchantBranchOrderTime,
    "merchant_branch_busy_added_time": merchantBranchBusyAddedTime,
    "merchant_branch_busy_end_time": merchantBranchBusyEndTime,
    "merchant_branch_id": merchantBranchId,
    "merchant_branch_address": merchantBranchAddress,
    "merchant_branch_name": merchantBranchName,
    "merchant_branch_busy": merchantBranchBusy,
    "merchant_branch_paymnet_mode": merchantBranchPaymnetMode,
    "merchant_branch_image": merchantBranchImage,
    "merchant_pack_charge": merchantPackCharge,
    "merchant_pack_charge_type": merchantPackChargeType,
    "country_currency": countryCurrency,
    "restaurant_area": restaurantArea,
    "distance": distance,
    "open_status": openStatus,
    "merchant_branch_paymnet_list": List<dynamic>.from(merchantBranchPaymnetList!.map((x) => x)),
  };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryNameArb,
    this.isActive,

  });

  String? categoryId;
  String? categoryName;
  String? categoryNameArb;
  bool? isActive;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryNameArb: json["category_name_arb"],
    isActive: true,
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_name_arb": categoryNameArb,
  };
}

class Item {
  Item({
    this.itemId,
    this.itemDeleteStatus,
    this.itemVisibility,
    this.itemVisibilityApproval,
    this.itemApproveStatus,
    this.itemMerchant,
    this.itemMerchantBranch,
    this.itemType,
    this.itemCategory,
    this.itemName,
    this.itemNameArabic,
    this.itemPriceType,
    this.itemPrice,
    this.itemOfferPrice,
    this.itemDescription,
    this.itemDescriptionArabic,
    this.itemFlavour,
    this.itemVegNonveg,
    this.itemImage,
    this.itemCuisine,
    this.itemAvailableDays,
    this.itemAvailableTimeFrom,
    this.itemAvailableTimeTo,
    this.itemCartSlider,
    this.itemStartDate,
    this.itemEndDate,
    this.itemFromDate,
    this.itemToDate,
    this.itemAddedDate,
    this.itemAddedBy,
    this.itemAdddedType,
    this.itemPaymentMode,
    this.foodItemHomeVisible,
    this.itemOfferStatus,
    this.itemOfferPercentage,
    this.itemOfferAmt,
    this.hideLimitTime,
    this.hideLimitDate,
    this.isEggIncluded,
    this.itemPackageCharge,
    this.categoryId,
    this.categoryDeleteStatus,
    this.categoryBranchId,
    this.categoryVisibility,
    this.categoryDisplayOrder,
    this.categoryName,
    this.categoryNameArb,
    this.categoryAddedDate,
    this.categoryModifiedon,
    this.categoryAddedBy,
    this.categoryEditedBy,
    this.categoryAddedUserType,
    this.categoryEdittedUserType,
    this.restStatus,
    this.availableTime,
    this.availableDay,
    this.isPriceon,
    this.isAddon,this.enteredQty
  });

  String? itemId;
  String? itemDeleteStatus;
  String? itemVisibility;
  String? itemVisibilityApproval;
  String? itemApproveStatus;
  String? itemMerchant;
  String? itemMerchantBranch;
  String? itemType;
  String? itemCategory;
  String? itemName;
  String? itemNameArabic;
  String? itemPriceType;
  int? itemPrice;
  String? itemOfferPrice;
  String? itemDescription;
  String? itemDescriptionArabic;
  String? itemFlavour;
  String? itemVegNonveg;
  String? itemImage;
  String? itemCuisine;
  String? itemAvailableDays;
  String? itemAvailableTimeFrom;
  String? itemAvailableTimeTo;
  String? itemCartSlider;
  String? itemStartDate;
  String? itemEndDate;
  String? itemFromDate;
  String? itemToDate;
  DateTime? itemAddedDate;
  String? itemAddedBy;
  String? itemAdddedType;
  String? itemPaymentMode;
  String? foodItemHomeVisible;
  String? itemOfferStatus;
  String? itemOfferPercentage;
  dynamic itemOfferAmt;
  dynamic hideLimitTime;
  dynamic hideLimitDate;
  dynamic isEggIncluded;
  dynamic itemPackageCharge;
  String? categoryId;
  String? categoryDeleteStatus;
  String? categoryBranchId;
  String? categoryVisibility;
  String? categoryDisplayOrder;
  String? categoryName;
  String? categoryNameArb;
  DateTime? categoryAddedDate;
  String? categoryModifiedon;
  String? categoryAddedBy;
  String? categoryEditedBy;
  String? categoryAddedUserType;
  String? categoryEdittedUserType;
  String? restStatus;
  String? availableTime;
  String? availableDay;
  int? isPriceon;
  int? isAddon;
  int? enteredQty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"],
    itemDeleteStatus: json["item_delete_status"],
    itemVisibility: json["item_visibility"],
    itemVisibilityApproval: json["item_visibility_approval"],
    itemApproveStatus: json["item_approve_status"],
    itemMerchant: json["item_merchant"],
    itemMerchantBranch: json["item_merchant_branch"],
    itemType: json["item_type"],
    itemCategory: json["item_category"],
    itemName: json["item_name"],
    itemNameArabic: json["item_name_arabic"],
    itemPriceType: json["item_price_type"],
    itemPrice: json["item_price"],
    itemOfferPrice: json["item_offer_price"],
    itemDescription: json["item_description"],
    itemDescriptionArabic: json["item_description_arabic"],
    itemFlavour: json["item_flavour"],
    itemVegNonveg: json["item_veg_nonveg"],
    itemImage: json["item_image"],
    itemCuisine: json["item_cuisine"],
    itemAvailableDays: json["item_available_days"],
    itemAvailableTimeFrom: json["item_available_time_from"],
    itemAvailableTimeTo: json["item_available_time_to"],
    itemCartSlider: json["item_cart_slider"],
    itemStartDate: json["item_start_date"],
    itemEndDate: json["item_end_date"],
    itemFromDate: json["item_from_date"],
    itemToDate: json["item_to_date"],
    itemAddedDate: DateTime.parse(json["item_added_date"]),
    itemAddedBy: json["item_added_by"],
    itemAdddedType: json["item_addded_type"],
    itemPaymentMode: json["item_payment_mode"],
    foodItemHomeVisible: json["food_item_home_visible"],
    itemOfferStatus: json["item_offer_status"],
    itemOfferPercentage: json["item_offer_percentage"],
    itemOfferAmt: json["item_offer_amt"],
    hideLimitTime: json["hide_limit_time"],
    hideLimitDate: json["hide_limit_date"],
    isEggIncluded: json["is_egg_included"],
    itemPackageCharge: json["item_package_charge"],
    categoryId: json["category_id"],
    categoryDeleteStatus: json["category_delete_status"],
    categoryBranchId: json["category_branch_id"],
    categoryVisibility: json["category_visibility"],
    categoryDisplayOrder: json["category_display_order"],
    categoryName: json["category_name"],
    categoryNameArb: json["category_name_arb"],
    categoryAddedDate: DateTime.parse(json["category_added_date"]),
    categoryModifiedon: json["category_modifiedon"],
    categoryAddedBy: json["category_added_by"],
    categoryEditedBy: json["category_edited_by"],
    categoryAddedUserType: json["category_added_user_type"],
    categoryEdittedUserType: json["category_editted_user_type"],
    restStatus: json["rest_status"],
    availableTime: json["available_time"],
    availableDay: json["available_day"],
    isPriceon: json["is_priceon"],
    isAddon: json["is_addon"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_delete_status": itemDeleteStatus,
    "item_visibility": itemVisibility,
    "item_visibility_approval": itemVisibilityApproval,
    "item_approve_status": itemApproveStatus,
    "item_merchant": itemMerchant,
    "item_merchant_branch": itemMerchantBranch,
    "item_type": itemType,
    "item_category": itemCategory,
    "item_name": itemName,
    "item_name_arabic": itemNameArabic,
    "item_price_type": itemPriceType,
    "item_price": itemPrice,
    "item_offer_price": itemOfferPrice,
    "item_description": itemDescription,
    "item_description_arabic": itemDescriptionArabic,
    "item_flavour": itemFlavour,
    "item_veg_nonveg": itemVegNonveg,
    "item_image": itemImage,
    "item_cuisine": itemCuisine,
    "item_available_days": itemAvailableDays,
    "item_available_time_from": itemAvailableTimeFrom,
    "item_available_time_to": itemAvailableTimeTo,
    "item_cart_slider": itemCartSlider,
    "item_start_date": itemStartDate,
    "item_end_date": itemEndDate,
    "item_from_date": itemFromDate,
    "item_to_date": itemToDate,
    "item_added_date": itemAddedDate,
    "item_added_by": itemAddedBy,
    "item_addded_type": itemAdddedType,
    "item_payment_mode": itemPaymentMode,
    "food_item_home_visible": foodItemHomeVisible,
    "item_offer_status": itemOfferStatus,
    "item_offer_percentage": itemOfferPercentage,
    "item_offer_amt": itemOfferAmt,
    "hide_limit_time": hideLimitTime,
    "hide_limit_date": hideLimitDate,
    "is_egg_included": isEggIncluded,
    "item_package_charge": itemPackageCharge,
    "category_id": categoryId,
    "category_delete_status": categoryDeleteStatus,
    "category_branch_id": categoryBranchId,
    "category_visibility": categoryVisibility,
    "category_display_order": categoryDisplayOrder,
    "category_name": categoryName,
    "category_name_arb": categoryNameArb,
    "category_added_date": categoryAddedDate,
    "category_modifiedon": categoryModifiedon,
    "category_added_by": categoryAddedBy,
    "category_edited_by": categoryEditedBy,
    "category_added_user_type": categoryAddedUserType,
    "category_editted_user_type": categoryEdittedUserType,
    "rest_status": restStatus,
    "available_time": availableTime,
    "available_day": availableDay,
    "is_priceon": isPriceon,
    "is_addon": isAddon,
  };
}

class Reviews {
  Reviews({
    this.numOfRows,
    this.result,
    this.branchAvgRating,
  });

  int? numOfRows;
  List<dynamic>? result;
  int? branchAvgRating;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    numOfRows: json["num_of_rows"],
    result: List<dynamic>.from(json["result"].map((x) => x)),
    branchAvgRating: json["branch_avg_rating"],
  );

  Map<String, dynamic> toJson() => {
    "num_of_rows": numOfRows,
    "result": List<dynamic>.from(result!.map((x) => x)),
    "branch_avg_rating": branchAvgRating,
  };
}

class Timing {
  Timing({
    this.monday,
  });

  List<Monday>? monday;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    monday: List<Monday>.from(json["monday"].map((x) => Monday.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "monday": List<dynamic>.from(monday!.map((x) => x.toJson())),
  };
}

class Monday {
  Monday({
    this.restTimingDay,
    this.restTimingRestId,
    this.restTimingOpenTime,
    this.restTimingCloseTime,
    this.dayName,
  });

  String? restTimingDay;
  String? restTimingRestId;
  String? restTimingOpenTime;
  String? restTimingCloseTime;
  String? dayName;

  factory Monday.fromJson(Map<String, dynamic> json) => Monday(
    restTimingDay: json["rest_timing_day"],
    restTimingRestId: json["rest_timing_rest_id"],
    restTimingOpenTime: json["rest_timing_open_time"],
    restTimingCloseTime: json["rest_timing_close_time"],
    dayName: json["day_name"],
  );

  Map<String, dynamic> toJson() => {
    "rest_timing_day": restTimingDay,
    "rest_timing_rest_id": restTimingRestId,
    "rest_timing_open_time": restTimingOpenTime,
    "rest_timing_close_time": restTimingCloseTime,
    "day_name": dayName,
  };
}