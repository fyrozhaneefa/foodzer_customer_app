import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:foodzer_customer_app/Models/SliderModel.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageSlider extends StatefulWidget {

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {

  List<SliderModel> slider =[];

  @override
  void initState() {
    getSliderList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
       Column(
         children: [
           Container(
             margin: EdgeInsets.only(bottom: 25),
             child: CarouselSlider(
                  // items: banners(),
               items:  slider
                   .map((item) => InkWell(
                 onTap: (){
                   print(item.sliderMerchantId);
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (BuildContext context) =>
                           RestaurantDetailsScreen(item.sliderMerchantId,item.lat,item.lng)));
                 },
                     child: Container(
                 // margin: EdgeInsets.only(left: 20,right: 20),
                 child: ClipRRect(
                       borderRadius: BorderRadius.circular(8.0),
                       child: CachedNetworkImage(
                         fit: BoxFit.fill,
                           height: double.infinity,
                           width: double.infinity,
                         filterQuality: FilterQuality.high,
                         imageUrl:item.sliderImage!,
                       ),
                       // Image.network(
                       //   item.sliderImage!,
                       //   // 'https://www.pexels.com/photo/1640777/download/',
                       //   fit: BoxFit.fill,
                       //   loadingBuilder: (BuildContext context, Widget child,
                       //       ImageChunkEvent? loadingProgress) {
                       //     if (loadingProgress == null) return child;
                       //     return Center(
                       //       child: CircularProgressIndicator(
                       //         color: Colors.deepOrangeAccent,
                       //         value: loadingProgress.expectedTotalBytes != null
                       //             ? loadingProgress.cumulativeBytesLoaded /
                       //             loadingProgress.expectedTotalBytes!
                       //             : null,
                       //       ),
                       //     );
                       //   },
                       //   height: double.infinity,
                       //   width: double.infinity,
                       // )
                 ),
               ),
                   )).toList(),
                  options: CarouselOptions(
                   pageSnapping: true,
                    height: 135,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    aspectRatio: 16 / 9,
                    // viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: slider.length>1? true:false,
                    reverse: false,
                    autoPlay:true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.linear,
                    enlargeCenterPage: true,
                    onPageChanged: (int index, CarouselPageChangedReason reason) {},
                    scrollDirection: Axis.horizontal,
                  )
              ),
           ),
         ],
       );



  }


  getSliderList() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    map['lat'] = prefs.getString('latitude');
    map['lng'] = prefs.getString('longitude');
    var response= await http.post(Uri.parse(ApiData.HOME_PAGE),body:map);
    var jsonData = convert.jsonDecode(response.body);
    if(jsonData['error_code'] == 0){
      List dataList = jsonData['advertisements'];
      if(null!= dataList && dataList.length >0){
        slider =dataList.map((spacecraft) => new SliderModel.fromJson(spacecraft)).toList();
      }
      setState(() {

      });
    } else{
      print("some error occured!!!");
    }


  }
}
