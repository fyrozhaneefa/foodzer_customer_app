import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';
class CartAddons extends StatefulWidget {
  Item itemModel;
  int itemIndex=-1;
  CartAddons(this.itemModel,this.itemIndex) ;

  @override
  _CartAddonsState createState() => _CartAddonsState();
}

class _CartAddonsState extends State<CartAddons> {

  List<Addons> addonModelList = [];
  bool isLoading = false;
  dynamic itemPrice;
  dynamic totalPrice;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.itemModel.isAddon == 1){
      getCartAddons();
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading?
    Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrangeAccent,
      ),
    ):
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 25,
                  bottom: 10,
                  left: 20,
                  right: 10),
              child: InkWell(
                  child: Icon(
                      Icons.clear_outlined),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            Container(child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 25, bottom: 10),
                  child: Text(
                 widget.itemModel.itemName
                        .toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w600),
                  ),
                ),
                Text(
                  ('₹${widget.itemModel.itemPrice}'),
                  style:
                  TextStyle(fontSize: 13),
                ),

              ],
            ),
            ),
          ],),
        SizedBox(height: 10,),
        MySeparator(),
        Flexible(
          child:
          ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: addonModelList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            addonModelList[index].addonsSubTitleName.toString()),
                      ),
                      Row(
                        children: [
                          Text(
                              '(+ INR ${addonModelList[index].addonsSubTitlePrice})'),
                          Checkbox(
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(3),
                            ),
                            activeColor:
                            Colors.deepOrangeAccent,
                            value: addonModelList[index].isSelected,
                            onChanged: (checked) {
                              setState(
                                    () {
                                  addonModelList[index].isSelected = checked;

                                },
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              })
        ),
        MySeparator(),
        saveBtn(),
      ],
    );
  }
  Widget saveBtn(){
    double totalAddonPrice=0;
    if(null!=addonModelList && addonModelList.length>0){
      for(Addons addon in addonModelList){
        if(addon.isSelected!) {
          totalAddonPrice = totalAddonPrice + addon.addonsSubTitlePrice!;
        }
      }
    }
    totalAddonPrice=totalAddonPrice+widget.itemModel.itemPrice!;
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('₹${totalAddonPrice.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
              ),
              SizedBox(height: 5,),
              Text('View customized Items',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,

                ),
              ),
            ],
          ),
          Container(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.itemModel.addonsList=addonModelList.where((element) => element.isSelected == true).toList();
                Provider.of<ApplicationProvider>(context,
                    listen: false).updateProduct(widget.itemModel,true,widget.itemModel.enteredQty!);
                Navigator.of(context).pop();
              },
              child: Text(
                'Update Item to Cart',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    // side: BorderSide(color: Colors.grey)
                  )),
            ),
          ),
        ],
      ),
    );
  }
  getCartAddons() async {
    isLoading =true;
    setState(() {

    });
    var map = new Map<String, dynamic>();
    map['item_id'] =
    widget.itemModel.itemId;
    var response =
    await http.post(Uri.parse(ApiData.GET_ITEM_ADDONS), body: map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['addons'];
    if (null != dataList && dataList.length > 0) {
      addonModelList = dataList
          .map((spacecraft) => new Addons.fromJson(spacecraft))
          .toList();

      if(null!=widget.itemModel.addonsList && widget.itemModel.addonsList!.length>0){
        for(Addons  addonModel in widget.itemModel.addonsList!){
          if(addonModel.isSelected!){
            addonModelList.where((element) => element.itemAddonsSubtitleTblid
                == addonModel.itemAddonsSubtitleTblid).first.isSelected = true;
            // totalPrice = double.parse(
            //     totalPrice.toString()) +  addonModel.addonsSubTitlePrice!;
            setState(() {

            });
          }
        }
      }
      isLoading =false;
      setState(() {

      });
      // Provider.of<ApplicationProvider>(context, listen: false)
      //     .setItemAddons(addonModelList);
    }
  }
}
