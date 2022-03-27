// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:foodzer_customer_app/screens/innerdetails/section/productCategoryItem.dart';
//
// class PersistentHeader extends SliverPersistentHeaderDelegate {
//   String? merchantBranchId,lat,lng;
//
//   PersistentHeader(this.merchantBranchId, this.lat, this.lng);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return ProductCategoryItem(merchantBranchId,lat,lng);
//   }
//
//   @override
//   double get maxExtent => 56.0;
//
//   @override
//   double get minExtent => 56.0;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }