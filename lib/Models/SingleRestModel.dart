// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

import 'package:foodzer_customer_app/Models/itemPriceOnModel.dart';

SingleRestModel restaurantModelFromJson(String str) =>
    SingleRestModel.fromJson(json.decode(str));
String singleRestModelToJson(SingleRestModel data) =>
    json.encode(data.toJson());

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

  factory SingleRestModel.fromJson(Map<String, dynamic> json) =>
      SingleRestModel(
        categories: json.containsKey("categories")
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : [],
        offerDetails: json.containsKey("offer_details")
            ? List<dynamic>.from(json["offer_details"].map((x) => x))
            : [],
        timing: json.containsKey("timing")
            ? Timing.fromJson(json["timing"])
            : new Timing(),
        items: json.containsKey("items")
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : [],
        // items: List<List<Item>>.from(json["items"].map((x) => List<Item>.from(x.map((x) => Item.fromJson(x))))),
        avgQuality: json["avg_quality"],
        packageRating: json["package_rating"],
        deliveryRating: json["delivery_rating"],
        moneyRating: json["money_rating"],
        numOfRows: json["num_of_rows"],
        reviews: json.containsKey("reviews")
            ? Reviews.fromJson(json["reviews"])
            : new Reviews(),
        merchantBranchId: json["merchant_branch_id"],
        branchDetails: BranchDetails.fromJson(json["branch_details"]),
        branchCuisine: json["branch_cuisine"],
      );
  //
  Map<String, dynamic> toJson() => {
        "timing": timing!.toJson(),
        "avg_quality": avgQuality,
        "package_rating": packageRating,
        "delivery_rating": deliveryRating,
        "money_rating": moneyRating,
        "num_of_rows": numOfRows,
        "merchant_branch_id": merchantBranchId,
        "branch_details": branchDetails!.toJson(),
        "branch_cuisine": branchCuisine,
      };
}

class BranchDetails {
  BranchDetails(
      {this.merchantBranchNameArabi,
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
      this.merchantBranchCoverImage,
      this.deliveryAreaDeliveryTime});

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
  String? merchantBranchCoverImage;
  String? deliveryAreaDeliveryTime;

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
        merchantBranchCoverImage: json["merchant_branch_cover_image"],
        merchantPackCharge: json["merchant_pack_charge"],
        merchantPackChargeType: json["merchant_pack_charge_type"],
        countryCurrency: json["country_currency"],
        restaurantArea: json["restaurant_area"],
        distance: json["distance"],
        openStatus: json["open_status"],
        deliveryAreaDeliveryTime: json["delivery_area_delivery_time"],
        merchantBranchPaymnetList: List<String>.from(
            json["merchant_branch_paymnet_list"].map((x) => x)),
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
        "merchant_branch_cover_image": merchantBranchCoverImage,
        "merchant_pack_charge": merchantPackCharge,
        "merchant_pack_charge_type": merchantPackChargeType,
        "country_currency": countryCurrency,
        "restaurant_area": restaurantArea,
        "distance": distance,
        "open_status": openStatus,
        "delivery_area_delivery_time": deliveryAreaDeliveryTime,
        "merchant_branch_paymnet_list":
            List<dynamic>.from(merchantBranchPaymnetList!.map((x) => x)),
      };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryNameArb,
    this.isActive,
  });

  int? categoryId;
  String? categoryName;
  String? categoryNameArb;
  bool? isActive;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: int.parse(json["category_id"].toString()),
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
  static String encode(List<Item> productModelList) => json.encode(
        productModelList
            .map<Map<String, dynamic>>((data) => Item.preferenceToJson(data))
            .toList(),
      );

  Item(
      {this.itemId,
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
      this.isAddon,
      this.enteredQty,
      this.addonsList,
      this.addonIds,
      this.tempId,
      this.lastItemTempId,
      this.priceOnId,
      this.priceOnItemPrice,this.totalPrice});

  String? itemId;
  String? tempId;
  String? lastItemTempId;
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
  double? itemPrice;
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
  String? itemAddedDate;
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
  int? categoryId;
  String? categoryDeleteStatus;
  String? categoryBranchId;
  String? categoryVisibility;
  String? categoryDisplayOrder;
  String? categoryName;
  String? categoryNameArb;
  String? categoryAddedDate;
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
  double? totalPrice;
  List<Addons>? addonsList;
  String? addonIds;
  String? priceOnId;
  double? priceOnItemPrice;

  factory Item.fromJson(Map<String, dynamic> json) {
    List<Addons> addonList = [];
    if (json.containsKey("addonsList")) {
      var listJson=json["addonsList"];
      if(listJson is String) {
        var list = jsonDecode(listJson);
        addonList = List<Addons>.from(
            list.map((x) => Addons.fromJson(x)));
      }
    }
    return Item(
      addonsList: addonList,
      itemId: json["item_id"],
      tempId: json.containsKey("tempId") ? json["tempId"] : null,
      totalPrice: json.containsKey("totalPrice") ? json["totalPrice"] : null,
      enteredQty: json.containsKey("enteredQty") ? json["enteredQty"] : null,
      lastItemTempId:
          json.containsKey("lastItemTempId") ? json["lastItemTempId"] : null,
      priceOnId: json.containsKey("priceOnId") ? json["priceOnId"] : null,
      priceOnItemPrice:
          json.containsKey("priceOnItemPrice") ? json["priceOnItemPrice"] : 0,
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
      itemPrice: null != json["item_price"]
          ? json["item_price"] is double
              ? json["item_price"]
              : double.parse(json["item_price"].toString())
          : 0,
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
      itemAddedDate: json["item_added_date"],
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
      categoryId: null != json["category_id"]
          ? int.parse(json["category_id"].toString())
          : -1,
      categoryDeleteStatus: json["category_delete_status"],
      categoryBranchId: json["category_branch_id"],
      categoryVisibility: json["category_visibility"],
      categoryDisplayOrder: json["category_display_order"],
      categoryName: json["category_name"],
      categoryNameArb: json["category_name_arb"],
      categoryAddedDate: json["category_added_date"],
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
      addonIds: "",
    );
  }
  static String ToJson(Item model) {
    Map<String, dynamic> map() => {
          "item_id": model.itemId,
          "special_request": "",
          "price_on_id": 0,
          "qty": model.enteredQty,
          "addons_id": model.addonIds,
        };
    String result = json.encode(map());
    return result;
  }

  static Map<String, dynamic> preferenceToJson(Item model) => {
        "item_id": model.itemId,
        "tempId": model.tempId,
        "lastItemTempId": model.lastItemTempId,
        "item_delete_status": model.itemDeleteStatus,
        "item_visibility": model.itemVisibility,
        "item_visibility_approval": model.itemVisibilityApproval,
        "item_approve_status": model.itemApproveStatus,
        "item_merchant": model.itemMerchant,
        "item_merchant_branch": model.itemMerchantBranch,
        "item_type": model.itemType,
        "item_category": model.itemCategory,
        "item_name": model.itemName,
        "item_name_arabic": model.itemNameArabic,
        "item_price_type": model.itemPriceType,
        "item_price": model.itemPrice,
        "item_offer_price": model.itemOfferPrice,
        "item_description": model.itemDescription,
        "item_description_arabic": model.itemDescriptionArabic,
        "item_flavour": model.itemFlavour,
        "item_veg_nonveg": model.itemVegNonveg,
        "item_image": model.itemImage,
        "item_cuisine": model.itemCuisine,
        "item_available_days": model.itemAvailableDays,
        "item_available_time_from": model.itemAvailableTimeFrom,
        "item_available_time_to": model.itemAvailableTimeTo,
        "item_cart_slider": model.itemCartSlider,
        "item_start_date": model.itemStartDate,
        "item_end_date": model.itemEndDate,
        "item_from_date": model.itemFromDate,
        "item_to_date": model.itemToDate,
        "item_added_date": model.itemAddedDate,
        "item_added_by": model.itemAddedBy,
        "item_addded_type": model.itemAdddedType,
        "item_payment_mode": model.itemPaymentMode,
        "food_item_home_visible": model.foodItemHomeVisible,
        "item_offer_status": model.itemOfferStatus,
        "item_offer_percentage": model.itemOfferPercentage,
        "item_offer_amt": model.itemOfferAmt,
        "hide_limit_time": model.hideLimitTime,
        "hide_limit_date": model.hideLimitDate,
        "is_egg_included": model.isEggIncluded,
        "item_package_charge": model.itemPackageCharge,
        "category_id": model.categoryId,
        "category_delete_status": model.categoryDeleteStatus,
        "category_branch_id": model.categoryBranchId,
        "category_visibility": model.categoryVisibility,
        "category_display_order": model.categoryDisplayOrder,
        "category_name": model.categoryName,
        "category_name_arb": model.categoryNameArb,
        "category_added_date": model.categoryAddedDate,
        "category_modifiedon": model.categoryModifiedon,
        "category_added_by": model.categoryAddedBy,
        "category_edited_by": model.categoryEditedBy,
        "category_added_user_type": model.categoryAddedUserType,
        "category_editted_user_type": model.categoryEdittedUserType,
        // "addons_sub_title_id": addonsSubTitleId,
        "rest_status": model.restStatus,
        "available_time": model.availableTime,
        "available_day": model.availableDay,
        "is_priceon": model.isPriceon,
        "is_addon": model.isAddon,
        "priceOnId": model.priceOnId,
        "priceOnItemPrice": model.priceOnItemPrice,
        "totalPrice": model.totalPrice,
        "enteredQty": model.enteredQty,
        "addonsList": null != model.addonsList && model.addonsList!.length > 0
            ? json.encode(
                model.addonsList!
                    .map<Map<String, dynamic>>(
                        (data) => Addons.preferenceToJson(data))
                    .toList(),
              )
            : []
      };
  static String toDataJson(Item model) {
    Map<String, dynamic> map() => {
          "item_id": model.itemId,
          "tempId": model.tempId,
          "lastItemTempId": model.lastItemTempId,
          "item_delete_status": model.itemDeleteStatus,
          "item_visibility": model.itemVisibility,
          "item_visibility_approval": model.itemVisibilityApproval,
          "item_approve_status": model.itemApproveStatus,
          "item_merchant": model.itemMerchant,
          "item_merchant_branch": model.itemMerchantBranch,
          "item_type": model.itemType,
          "item_category": model.itemCategory,
          "item_name": model.itemName,
          "item_name_arabic": model.itemNameArabic,
          "item_price_type": model.itemPriceType,
          "item_price": model.itemPrice,
          "item_offer_price": model.itemOfferPrice,
          "item_description": model.itemDescription,
          "item_description_arabic": model.itemDescriptionArabic,
          "item_flavour": model.itemFlavour,
          "item_veg_nonveg": model.itemVegNonveg,
          "item_image": model.itemImage,
          "item_cuisine": model.itemCuisine,
          "item_available_days": model.itemAvailableDays,
          "item_available_time_from": model.itemAvailableTimeFrom,
          "item_available_time_to": model.itemAvailableTimeTo,
          "item_cart_slider": model.itemCartSlider,
          "item_start_date": model.itemStartDate,
          "item_end_date": model.itemEndDate,
          "item_from_date": model.itemFromDate,
          "item_to_date": model.itemToDate,
          "item_added_date": model.itemAddedDate,
          "item_added_by": model.itemAddedBy,
          "item_addded_type": model.itemAdddedType,
          "item_payment_mode": model.itemPaymentMode,
          "food_item_home_visible": model.foodItemHomeVisible,
          "item_offer_status": model.itemOfferStatus,
          "item_offer_percentage": model.itemOfferPercentage,
          "item_offer_amt": model.itemOfferAmt,
          "hide_limit_time": model.hideLimitTime,
          "hide_limit_date": model.hideLimitDate,
          "is_egg_included": model.isEggIncluded,
          "item_package_charge": model.itemPackageCharge,
          "category_id": model.categoryId,
          "category_delete_status": model.categoryDeleteStatus,
          "category_branch_id": model.categoryBranchId,
          "category_visibility": model.categoryVisibility,
          "category_display_order": model.categoryDisplayOrder,
          "category_name": model.categoryName,
          "category_name_arb": model.categoryNameArb,
          "category_added_date": model.categoryAddedDate,
          "category_modifiedon": model.categoryModifiedon,
          "category_added_by": model.categoryAddedBy,
          "category_edited_by": model.categoryEditedBy,
          "category_added_user_type": model.categoryAddedUserType,
          "category_editted_user_type": model.categoryEdittedUserType,
          // "addons_sub_title_id": addonsSubTitleId,
          "rest_status": model.restStatus,
          "available_time": model.availableTime,
          "available_day": model.availableDay,
          "is_priceon": model.isPriceon,
          "is_addon": model.isAddon,
          "priceOnId": model.priceOnId,
          "priceOnItemPrice": model.priceOnItemPrice,
        };
    String result = json.encode(map());
    return result;
  }
}

class Addons {
  Addons({
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
  int? addonsType;
  String? addonsArabi;
  String? addonsSubTitleName;
  String? addonsSubTitleArabi;
  double? addonsSubTitlePrice;
  dynamic displayOrder;
  bool? isSelected;

  factory Addons.fromJson(Map<String, dynamic> json) => Addons(
        itemAddonsTitleDisplayOrder:
            json["item_addons_title_display_order"] == null
                ? null
                : json["item_addons_title_display_order"],
        itemAddonsTitleTblid: json["item_addons_title_tblid"] == null
            ? null
            : json["item_addons_title_tblid"],
        itemAddonsTitleAddonsId: json["item_addons_title_addons_id"] == null
            ? null
            : json["item_addons_title_addons_id"],
        itemAddonsTitleCount: json["item_addons_title_count"] == null
            ? null
            : json["item_addons_title_count"],
        itemAddonsTitleType: json["item_addons_title_type"] == null
            ? null
            : json["item_addons_title_type"],
        itemAddonsTitleItemId: json["item_addons_title_item_id"] == null
            ? null
            : json["item_addons_title_item_id"],
        itemAddonsSubtitleTblid: json["item_addons_subtitle_tblid"] == null
            ? null
            : json["item_addons_subtitle_tblid"],
        itemAddonsSubtitleSubtitleId:
            json["item_addons_subtitle_subtitle_id"] == null
                ? null
                : json["item_addons_subtitle_subtitle_id"],
        addonsName: json["addons_name"] == null ? null : json["addons_name"],
        addonsType: json["addons_type"] == null
            ? 1
            : int.parse(json["addons_type"].toString()),
        addonsArabi: json["addons_arabi"] == null ? null : json["addons_arabi"],
        addonsSubTitleName: json["addons_sub_title_name"] == null
            ? null
            : json["addons_sub_title_name"],
        addonsSubTitleArabi: json["addons_sub_title_arabi"] == null
            ? null
            : json["addons_sub_title_arabi"],
        addonsSubTitlePrice: json["addons_sub_title_price"] == null
            ? null
            : double.parse(json["addons_sub_title_price"].toString()),
        displayOrder: json["display_order"],
        isSelected: json.containsKey("isSelected")? json["isSelected"]==1:false,
      );
  static Map<String, dynamic> preferenceToJson(Addons model) => {
        "item_addons_title_display_order": model.itemAddonsTitleDisplayOrder,
        "item_addons_title_tblid": model.itemAddonsTitleTblid,
        "item_addons_title_addons_id": model.itemAddonsTitleAddonsId,
        "item_addons_title_count": model.itemAddonsTitleCount,
        "item_addons_title_type": model.itemAddonsTitleType,
        "item_addons_title_item_id": model.itemAddonsTitleItemId,
        "item_addons_subtitle_tblid": model.itemAddonsSubtitleTblid,
        "item_addons_subtitle_subtitle_id": model.itemAddonsSubtitleSubtitleId,
        "addons_name": model.addonsName,
        "addons_type": model.addonsType,
        "addons_arabi": model.addonsArabi,
        "addons_sub_title_name": model.addonsSubTitleName,
        "addons_sub_title_arabi": model.addonsSubTitleArabi,
        "addons_sub_title_price": model.addonsSubTitlePrice,
        "display_order": model.displayOrder,
        "isSelected": model.isSelected!?1:0,
      };
  Map<String, dynamic> toJson() => {
        "item_addons_title_display_order": itemAddonsTitleDisplayOrder == null
            ? null
            : itemAddonsTitleDisplayOrder,
        "item_addons_title_tblid":
            itemAddonsTitleTblid == null ? null : itemAddonsTitleTblid,
        "item_addons_title_addons_id":
            itemAddonsTitleAddonsId == null ? null : itemAddonsTitleAddonsId,
        "item_addons_title_count":
            itemAddonsTitleCount == null ? null : itemAddonsTitleCount,
        "item_addons_title_type":
            itemAddonsTitleType == null ? null : itemAddonsTitleType,
        "item_addons_title_item_id":
            itemAddonsTitleItemId == null ? null : itemAddonsTitleItemId,
        "item_addons_subtitle_tblid":
            itemAddonsSubtitleTblid == null ? null : itemAddonsSubtitleTblid,
        "item_addons_subtitle_subtitle_id": itemAddonsSubtitleSubtitleId == null
            ? null
            : itemAddonsSubtitleSubtitleId,
        "addons_name": addonsName == null ? null : addonsName,
        "addons_type": addonsType == null ? null : addonsType,
        "addons_arabi": addonsArabi == null ? null : addonsArabi,
        "addons_sub_title_name":
            addonsSubTitleName == null ? null : addonsSubTitleName,
        "addons_sub_title_arabi":
            addonsSubTitleArabi == null ? null : addonsSubTitleArabi,
        "addons_sub_title_price":
            addonsSubTitlePrice == null ? null : addonsSubTitlePrice,
        "display_order": displayOrder,
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
        monday:
            List<Monday>.from(json["monday"].map((x) => Monday.fromJson(x))),
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
