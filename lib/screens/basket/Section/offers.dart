import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/couponModel.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  bool isLoading = false;
  UserData userModel = new UserData();
  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      if (null != value.userId && value.userId!.isNotEmpty) {
        userModel = value;
        getOfferCoupons();
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child)
    {
      return isLoading?Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),),):Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: InkWell(
            child: Icon(
              Icons.keyboard_backspace_outlined,
              color: Colors.black.withOpacity(.5),
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Offers",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.5),
              ),
              Row(
                children: [
                  Text(
                    "${provider.cartModelList.length} item ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    ".",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "Total:₹${provider.toPayAmt.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.white,
          actions: [],
          elevation: .5,
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Container(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         ElevatedButton(
        //           onPressed: (){},
        //             child:Text("Apply"),
        //           style: ElevatedButton.styleFrom(
        //             padding: EdgeInsets.symmetric(horizontal: 50),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12),
        //             ),
        //             primary: Colors.deepOrange
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
backgroundColor: Colors.grey.shade50,
body: SingleChildScrollView(
  child:   Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Enter a Voucher Code',
        //   style: TextStyle(
        //     color: Colors.deepOrangeAccent,
        //     fontSize: 18.0,
        //     fontWeight: FontWeight.w600
        //   ),
        // ),
        // Container(
        //   width: double.infinity,
        //   margin: EdgeInsets.only(top: 10, bottom: 10),
        //   decoration:BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(5.0),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(child: TextFormField(
        //         decoration: InputDecoration(
        //           hintText: 'Voucher Code',
        //           contentPadding: EdgeInsets.all(10),
        //         ),
        //       ),),
        //     ],
        //   ),
        // ),

        Text(
          'More offers',
          style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 16.0,
              fontWeight: FontWeight.w600
          ),
        ),
        SizedBox(height: 10,),
        ListView.builder(
            itemCount: provider.couponModelList.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5, bottom: 5),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: [
                // Text("1x",
                //   style: TextStyle(
                //     color: Colors.deepOrange,
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.w600
                //   ),),
                // SizedBox(width: 20,),
                Expanded(
                  child: Text(provider.couponModelList[index].couponCode.toString(),
                    style: TextStyle(
                    fontSize: 16.0,
                      fontWeight: FontWeight.w600
                  ),),
                ),
                TextButton(
                  onPressed: (){
                    if(provider.couponModelList[index].couponStatus == 1){
                      provider.setCouponToJson(provider.couponModelList[index],double.parse(provider.couponModelList[index].couponPrice.toString()));
                      Provider.of<ApplicationProvider>(
                          context,
                          listen: false)
                          .calculateTotal();
                      Navigator.pop(context);
                    } else{
                      Fluttertoast.showToast(
                          msg: "Coupon not available",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    }

                }, child: Text('Apply',
                  style: TextStyle(
                      color:provider.couponModelList[index].couponStatus == 1? Colors.deepOrangeAccent:Colors.grey),


                )
                )
              ],
            ),
          );
        })
      ],
    ),
  ),
),
      );
    });
  }
  getOfferCoupons() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['amount'] =   Provider.of<ApplicationProvider>(context ,listen: false).toPayAmt.toStringAsFixed(2);
    map['branch_id'] = Provider.of<ApplicationProvider>(context ,listen: false).selectedRestModel.merchantBranchId;
    map['user_id'] = userModel.userId;
    var response =
    await http.post(Uri.parse(ApiData.GET_OFFERS_LIST),body: map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['coupon_list'];
    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      if (null != dataList && dataList.length > 0) {
        List<CouponModelList> couponModel= [];
        couponModel = dataList
            .map((coupon) => new CouponModelList.fromJson(coupon))
            .toList();
        Provider.of<ApplicationProvider>(context ,listen: false).setCoupons(couponModel);
        setState(() {});
      }
    }
  }
}
