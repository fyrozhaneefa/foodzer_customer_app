import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  final double? value;

  const ShimmerWidget.rectangular(
      {this.value,this.width = double.infinity, required this.height,this.shapeBorder = const RoundedRectangleBorder()});

  const ShimmerWidget.circular({this.value,

    required this.height,
    required this.width,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
          width: width,
          height: height,

          decoration: ShapeDecoration(shape: shapeBorder, color: Colors.grey) ),
    );
  }
}
