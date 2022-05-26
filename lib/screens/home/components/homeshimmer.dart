import 'package:flutter/material.dart';

import '../../../utils/helper.dart';
import '../../allrestaurants/section/shimmer/shimmerwidget.dart';

class HomeShimmer extends StatefulWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  State<HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<HomeShimmer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: ShimmerWidget.rectangular(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 30,
              width: Helper.getScreenWidth(context) * .8),
        ),
        SingleChildScrollView(scrollDirection: Axis.horizontal,
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: ShimmerWidget.rectangular(
                  height: 110,
                  width: 110,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: ShimmerWidget.rectangular(
                  height: 110,
                  width: 110,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 20, right: 10),
              child: ShimmerWidget.rectangular(
                  height: 110,
                  width: 110,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            )
          ]),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ShimmerWidget.rectangular(
              height: 150,
              width: Helper.getScreenWidth(context),
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: ShimmerWidget.rectangular(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 30,
              width: Helper.getScreenWidth(context) * .8),
        ),
        Row(children: [
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: ShimmerWidget.rectangular(
                height: 100,
                width: 100,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: ShimmerWidget.rectangular(
                height: 100,
                width: 100,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: ShimmerWidget.rectangular(
                height: 100,
                width: 100,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ]),
        Padding(
          padding: EdgeInsets.all(20),
          child: ShimmerWidget.rectangular(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 30,
              width: Helper.getScreenWidth(context) * .8),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: ShimmerWidget.rectangular(
              height: 150,
              width: Helper.getScreenWidth(context),
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}
