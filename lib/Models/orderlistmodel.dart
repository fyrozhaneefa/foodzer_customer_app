class OrderListModel {
  List<OrderList>? orderList;

  OrderListModel({this.orderList});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['order_list'] != null) {
      orderList = <OrderList>[];
      json['order_list'].forEach((v) {
        orderList!.add(new OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderList != null) {
      data['order_list'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  String? merchantBranchId;
  String? merchantBranchName;
  String? merchantBranchNameArabi;
  String? merchantBranchImage;
  String? merchantBranchTelephone;
  String? orderId;
  String? orderStatus;
  String? orderPickupDeliveryStatus;
  String? orderDate;
  String? orderAddress;
  String? orderTotalAmount;
  String? orderAmount;
  String? orderExpectedTime;
  String? orderTaxCharge;
  String? orderDeliveryCharge;
  String? orderPaymentType;
  String? orderPaymentMode;
  String? orderPaymentStatus;
  String? orderDeliveryTime;
  String? orderDeclineReason;
  List<ItemDetails>? itemDetails;

  OrderList(
      {this.merchantBranchId,
        this.merchantBranchName,
        this.merchantBranchNameArabi,
        this.merchantBranchImage,
        this.merchantBranchTelephone,
        this.orderId,
        this.orderStatus,
        this.orderPickupDeliveryStatus,
        this.orderDate,
        this.orderAddress,
        this.orderTotalAmount,
        this.orderAmount,
        this.orderExpectedTime,
        this.orderTaxCharge,
        this.orderDeliveryCharge,
        this.orderPaymentType,
        this.orderPaymentMode,
        this.orderPaymentStatus,
        this.orderDeliveryTime,
        this.orderDeclineReason,
        this.itemDetails});

  OrderList.fromJson(Map<String, dynamic> json) {
    merchantBranchId = json['merchant_branch_id'];
    merchantBranchName = json['merchant_branch_name'];
    merchantBranchNameArabi = json['merchant_branch_name_arabi'];
    merchantBranchImage = json['merchant_branch_image'];
    merchantBranchTelephone = json['merchant_branch_telephone'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
    orderPickupDeliveryStatus = json['order_pickup_delivery_status'];
    orderDate = json['order_date'];
    orderAddress = json['order_address'];
    orderTotalAmount = json['order_total_amount'];
    orderAmount = json['order_amount'];
    orderExpectedTime = json['order_expected_time'];
    orderTaxCharge = json['order_tax_charge'];
    orderDeliveryCharge = json['order_delivery_charge'];
    orderPaymentType = json['order_payment_type'];
    orderPaymentMode = json['order_payment_mode'];
    orderPaymentStatus = json['order_payment_status'];
    orderDeliveryTime = json['order_delivery_time'];
    orderDeclineReason = json['order_decline_reason'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_branch_id'] = this.merchantBranchId;
    data['merchant_branch_name'] = this.merchantBranchName;
    data['merchant_branch_name_arabi'] = this.merchantBranchNameArabi;
    data['merchant_branch_image'] = this.merchantBranchImage;
    data['merchant_branch_telephone'] = this.merchantBranchTelephone;
    data['order_id'] = this.orderId;
    data['order_status'] = this.orderStatus;
    data['order_pickup_delivery_status'] = this.orderPickupDeliveryStatus;
    data['order_date'] = this.orderDate;
    data['order_address'] = this.orderAddress;
    data['order_total_amount'] = this.orderTotalAmount;
    data['order_amount'] = this.orderAmount;
    data['order_expected_time'] = this.orderExpectedTime;
    data['order_tax_charge'] = this.orderTaxCharge;
    data['order_delivery_charge'] = this.orderDeliveryCharge;
    data['order_payment_type'] = this.orderPaymentType;
    data['order_payment_mode'] = this.orderPaymentMode;
    data['order_payment_status'] = this.orderPaymentStatus;
    data['order_delivery_time'] = this.orderDeliveryTime;
    data['order_decline_reason'] = this.orderDeclineReason;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetails {
  String? price;
  String? orderTaxCharge;
  String? orderMerchantOffer;
  String? orderAdminOffer;
  String? orderTobePaidTotal;
  String? orderPakingCharge;
  String? itemName;
  String? itemAvailableTimeFrom;
  String? itemAvailableTimeTo;
  String? itemAvailableDays;
  String? itemVisibility;
  String? orderDetailsId;
  String? orderDetailsOrderId;
  String? orderDetailsItemId;
  String? orderDetailsQty;
  String? orderDetailsPriceOnId;
  String? orderDetailsAddons;
  String? orderDetailsFlavour;
  String? orderDetailsPriceType;
  String? orderDetailItemPrice;
  String? orderDetailsAddonsPrice;
  String? orderDetailTotalPrice;
  String? orderDetailItemTax;
  String? orderDetailsDate;
  Null? orderDetailsAreaDeliveryCharge;
  String? orderDetailsTimestamp;
  String? orderDetailsSpecialNote;
  String? addonsSubTitlePrice;

  ItemDetails(
      {this.price,
        this.orderTaxCharge,
        this.orderMerchantOffer,
        this.orderAdminOffer,
        this.orderTobePaidTotal,
        this.orderPakingCharge,
        this.itemName,
        this.itemAvailableTimeFrom,
        this.itemAvailableTimeTo,
        this.itemAvailableDays,
        this.itemVisibility,
        this.orderDetailsId,
        this.orderDetailsOrderId,
        this.orderDetailsItemId,
        this.orderDetailsQty,
        this.orderDetailsPriceOnId,
        this.orderDetailsAddons,
        this.orderDetailsFlavour,
        this.orderDetailsPriceType,
        this.orderDetailItemPrice,
        this.orderDetailsAddonsPrice,
        this.orderDetailTotalPrice,
        this.orderDetailItemTax,
        this.orderDetailsDate,
        this.orderDetailsAreaDeliveryCharge,
        this.orderDetailsTimestamp,
        this.orderDetailsSpecialNote,
        this.addonsSubTitlePrice});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    orderTaxCharge = json['order_tax_charge'];
    orderMerchantOffer = json['order_merchant_offer'];
    orderAdminOffer = json['order_admin_offer'];
    orderTobePaidTotal = json['order_tobe_paid_total'];
    orderPakingCharge = json['order_paking_charge'];
    itemName = json['item_name'];
    itemAvailableTimeFrom = json['item_available_time_from'];
    itemAvailableTimeTo = json['item_available_time_to'];
    itemAvailableDays = json['item_available_days'];
    itemVisibility = json['item_visibility'];
    orderDetailsId = json['order_details_id'];
    orderDetailsOrderId = json['order_details_order_id'];
    orderDetailsItemId = json['order_details_item_id'];
    orderDetailsQty = json['order_details_qty'];
    orderDetailsPriceOnId = json['order_details_price_on_id'];
    orderDetailsAddons = json['order_details_addons'];
    orderDetailsFlavour = json['order_details_flavour'];
    orderDetailsPriceType = json['order_details_price_type'];
    orderDetailItemPrice = json['order_detail_item_price'];
    orderDetailsAddonsPrice = json['order_details_addons_price'];
    orderDetailTotalPrice = json['order_detail_total_price'];
    orderDetailItemTax = json['order_detail_item_tax'];
    orderDetailsDate = json['order_details_date'];
    orderDetailsAreaDeliveryCharge = json['order_details_area_delivery_charge'];
    orderDetailsTimestamp = json['order_details_timestamp'];
    orderDetailsSpecialNote = json['order_details_special_note'];
    addonsSubTitlePrice = json['addons_sub_title_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['order_tax_charge'] = this.orderTaxCharge;
    data['order_merchant_offer'] = this.orderMerchantOffer;
    data['order_admin_offer'] = this.orderAdminOffer;
    data['order_tobe_paid_total'] = this.orderTobePaidTotal;
    data['order_paking_charge'] = this.orderPakingCharge;
    data['item_name'] = this.itemName;
    data['item_available_time_from'] = this.itemAvailableTimeFrom;
    data['item_available_time_to'] = this.itemAvailableTimeTo;
    data['item_available_days'] = this.itemAvailableDays;
    data['item_visibility'] = this.itemVisibility;
    data['order_details_id'] = this.orderDetailsId;
    data['order_details_order_id'] = this.orderDetailsOrderId;
    data['order_details_item_id'] = this.orderDetailsItemId;
    data['order_details_qty'] = this.orderDetailsQty;
    data['order_details_price_on_id'] = this.orderDetailsPriceOnId;
    data['order_details_addons'] = this.orderDetailsAddons;
    data['order_details_flavour'] = this.orderDetailsFlavour;
    data['order_details_price_type'] = this.orderDetailsPriceType;
    data['order_detail_item_price'] = this.orderDetailItemPrice;
    data['order_details_addons_price'] = this.orderDetailsAddonsPrice;
    data['order_detail_total_price'] = this.orderDetailTotalPrice;
    data['order_detail_item_tax'] = this.orderDetailItemTax;
    data['order_details_date'] = this.orderDetailsDate;
    data['order_details_area_delivery_charge'] =
        this.orderDetailsAreaDeliveryCharge;
    data['order_details_timestamp'] = this.orderDetailsTimestamp;
    data['order_details_special_note'] = this.orderDetailsSpecialNote;
    data['addons_sub_title_price'] = this.addonsSubTitlePrice;
    return data;
  }
}