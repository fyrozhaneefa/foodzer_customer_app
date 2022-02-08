import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class ImageSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
       Column(
         children: [
           Container(
             margin: EdgeInsets.only(bottom: 25),
             child: CarouselSlider(
                  items: banners(),
                  options: CarouselOptions(
                   pageSnapping: true,
                    height: 125,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.linear,
                    enlargeCenterPage: false,
                    onPageChanged: (int index, CarouselPageChangedReason reason) {},
                    scrollDirection: Axis.horizontal,
                  )
              ),
           ),
         ],
       );



  }

  List<Widget> banners(){
    List<Widget> banner = [] ;

    Widget bannerwid1 = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          Helper.getAssetName('banner1.jpg', 'virtual'),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
    Widget bannerwid2 = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          Helper.getAssetName('banner2.jpg', 'virtual'),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,

          alignment: Alignment.center,
        ),
      ),
    );
    Widget bannerwid3 = new Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          Helper.getAssetName('banner3.jpg', 'virtual'),
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,

          alignment: Alignment.center,
        ),
      ),
    );

    banner.add(bannerwid1);
    banner.add(bannerwid2);
    banner.add(bannerwid3);
    return banner;
  }
}
