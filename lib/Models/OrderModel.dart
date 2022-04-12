// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.merchantBranchId,
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
    this.deliveryType,
    this.addressId,
    this.couponId,
    this.lat,
    this.lng,
    this.specialNote,
    this.userId,
    this.walletAmt
  });

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

  String? lat,lng,deliveryType,addressId,userId,couponId,specialNote,walletAmt;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    merchantBranchId: json["merchant_branch_id"] == null ? null : json["merchant_branch_id"],
    merchantBranchName: json["merchant_branch_name"] == null ? null : json["merchant_branch_name"],
    merchantBranchNameArabi: json["merchant_branch_name_arabi"] == null ? null : json["merchant_branch_name_arabi"],
    merchantBranchImage: json["merchant_branch_image"] == null ? null : json["merchant_branch_image"],
    merchantBranchTelephone: json["merchant_branch_telephone"] == null ? null : json["merchant_branch_telephone"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    orderStatus: json["order_status"] == null ? null : json["order_status"],
    orderPickupDeliveryStatus: json["order_pickup_delivery_status"] == null ? null : json["order_pickup_delivery_status"],
    orderDate: json["order_date"] == null ? null :json["order_date"],
    orderAddress: json["order_address"] == null ? null : json["order_address"],
    orderTotalAmount: json["order_total_amount"] == null ? null : json["order_total_amount"],
    orderAmount: json["order_amount"] == null ? null : json["order_amount"],
    orderExpectedTime: json["order_expected_time"] == null ? null :json["order_expected_time"],
    orderTaxCharge: json["order_tax_charge"] == null ? null : json["order_tax_charge"],
    orderDeliveryCharge: json["order_delivery_charge"] == null ? null : json["order_delivery_charge"],
    orderPaymentType: json["order_payment_type"] == null ? null : json["order_payment_type"],
    orderPaymentMode: json["order_payment_mode"] == null ? null : json["order_payment_mode"],
    orderPaymentStatus: json["order_payment_status"] == null ? null : json["order_payment_status"],
    orderDeliveryTime: json["order_delivery_time"] == null ? null : json["order_delivery_time"],
    orderDeclineReason: json["order_decline_reason"] == null ? null : json["order_decline_reason"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "merchant_branch": merchantBranchId,
    "payment_mode": orderPaymentMode,
    "delivery_fee": orderDeliveryCharge,
    "DEL_TYPE": deliveryType,
    "address_id": addressId,
    "user_id": userId,
    "coupon_id": couponId,
    "special_note": specialNote,
    "wallet_amount": walletAmt,

  };
}
