import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';

import '../../blocs/application_bloc.dart';

class RestaurantInfoScreen extends StatefulWidget {
  static const routeName = "/restaurantInfo";

  // RestaurantInfoScreen(BranchDetails branchDetails);
// BranchDetails _branchDetails = new BranchDetails();
SingleRestModel _singleRestModel;
  RestaurantInfoScreen(this._singleRestModel);

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Consumer<ApplicationProvider>(
        builder: (context, provider, child) { return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      widget._singleRestModel.branchDetails!.merchantBranchImage!,
                      // 'https://www.graphicsprings.com/filestorage/stencils/0ce1371eaa6b98bbc23caf8655fdd713.png?width=500&height=500',
                    fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget._singleRestModel.branchDetails!.merchantBranchName!,
                        // 'Caribou Coffee',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                       widget._singleRestModel.branchCuisine!
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        null !=
                            provider.selectedRestModel
                                .reviews!.numOfRows &&
                            provider.selectedRestModel
                                .reviews!.numOfRows ==
                                0
                            ? Icons.sentiment_dissatisfied
                            : Icons.tag_faces,
                        color: null !=
                            provider.selectedRestModel
                                .reviews!.numOfRows &&
                            provider.selectedRestModel
                                .reviews!.numOfRows ==
                                0
                            ? Colors.grey.shade700
                            : Colors.grey.shade700,
                        size: 25,
                      ),
                      SizedBox(width: 10,),
                      Text(
                          null !=
                              provider
                                  .selectedRestModel
                                  .reviews!
                                  .numOfRows &&
                              provider
                                  .selectedRestModel
                                  .reviews!
                                  .numOfRows ==
                                  0
                              ? "No review yet "
                              : provider
                              .selectedRestModel
                              .reviews!
                              .branchAvgRating
                              .toString(),
                          style:TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15
                          )
                      )
                    ],
                  )
                ),
                Container(
                    child: Text(
                  '${provider
                      .selectedRestModel.reviews!
                      .numOfRows} ratings',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15
                      ),
                ))
              ],
            ),
            SizedBox(
              height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.location_city
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Restaurant Area',
                            style:TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                ),
                Container(
                    child: Text(
                       provider.selectedRestModel.branchDetails!.restaurantArea.toString(),
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15
                      ),
                    ))
              ],
            ),
            SizedBox(
                height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.watch_later_outlined
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Opening hours',
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                          )
                        )
                      ],
                    )
                ),
                Container(
                    child: Text(
                       widget._singleRestModel.todaysRestOpenTime.toString()+" - "+widget._singleRestModel.todaysRestCloseTime.toString() ,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15
                      ),
                    ))
              ],
            ),
            SizedBox(
                height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.delivery_dining
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Delivery time',
                            style:TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                ),
                Container(
                    child: Text(
                        provider.selectedRestModel.branchDetails!.merchantBranchOrderTime.toString() +" Mins",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15
                      ),
                    ))
              ],
            ),
            SizedBox(
                height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.account_balance_wallet_outlined
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Minimum order',
                            style:TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                ),
                Container(
                    child: Text(
                        '${widget._singleRestModel.branchDetails!.countryCurrency}.${widget._singleRestModel.branchDetails!.merchantBranchMinOrderAmnt}',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15
                      ),
                    ))
              ],
            ),
            SizedBox(
                height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.description_outlined
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Delivery fee',
                            style:TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                ),
                Container(
                    child: Text(
                        '${widget._singleRestModel.branchDetails!.countryCurrency}.${provider.selectedRestModel.branchDetails!.deliveryCharge.toString()}',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15
                      ),
                    ))
              ],
            ),
            SizedBox(
                height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.error_outline
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Pre order',
                            style:TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                ),
                Container(
                    child: Text(
                        'Yes',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15
                      ),
                    ))
              ],
            ),
            SizedBox(
                height: 30,
                child: Divider(thickness: 1,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                      children: [
                        Icon(
                            Icons.payment_outlined
                        ),
                        SizedBox(width: 10,),
                        Text(
                            'Payment options',
                            style:TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                ),
                Container(
                    child: Row(
                        children: [
                          ClipRRect(child: Image(width: 30,height: 30,image: AssetImage("assets/images/virtual/mastercard.png")),),
                          SizedBox(width: 5,),
                          ClipRRect(child: Image(width: 30,height: 30,image: AssetImage("assets/images/real/visa2.png")),),
                          SizedBox(width: 5,),
                          ClipRRect(child: Image(width: 27,height: 27,image: AssetImage("assets/images/real/google-pay-logo-png-removebg-preview.png")),),
                          SizedBox(width: 5,),
                          ClipRRect(child: Image(width: 30,height: 30,image: AssetImage("assets/images/real/phonepayLogo2.png")),),


                        ],
                    ),
                ),
              ],
            ),

          ],
        ),
      );
    }));
  }
}
