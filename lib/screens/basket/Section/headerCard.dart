import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:provider/provider.dart';

import '../../../Menu/Microfiles/PaymentSection/Constants/sapperator.dart';
import '../../../utils/helper.dart';

class BasketHeader extends StatefulWidget {
  // dynamic totalPrice;
  // BasketHeader(this.totalPrice);
  @override
  _BasketHeaderState createState() => _BasketHeaderState();
}

class _BasketHeaderState extends State<BasketHeader> {
  bool isAddons = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(
        builder: (context, provider, child)
    {
      return Container(

        width: Helper.getScreenWidth(context) * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("WELCOME50 eligible items",
                  style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w500)),
            ),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.cartModelList.length,
                itemBuilder: (BuildContext context, int index) {

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                provider.cartModelList[index].itemName.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  height: 1.3
                                ),
                              ),
                            ),
                            flex: 10,
                          ),
                          Container(
                            height: 30,
                            width: 90,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade400, width: 0.5),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 5, right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Provider.of<ApplicationProvider>(context,
                                            listen: false)
                                            .updateProduct(provider.cartModelList[index],
                                            false,
                                            provider.cartModelList[index].enteredQty! - 1);
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.green[700],
                                        size: 20,
                                      ),
                                    )),
                                Text(provider.cartModelList[index].enteredQty.toString(),
                                    style: TextStyle(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<ApplicationProvider>(context,
                                          listen: false)
                                          .updateProduct(provider.cartModelList[index],
                                         true,
                                          provider.cartModelList[index].enteredQty! + 1);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.green[700],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  // "₹320",
                                  ('₹${provider.cartModelList[index].totalPrice.toString()}'),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                     null!=provider.cartModelList[index].addonsList && provider.cartModelList[index].addonsList!.length>0?
                      ListView.builder(
                        physics: ScrollPhysics(),
                      shrinkWrap: true,
                        itemCount:provider.cartModelList[index].addonsList!.length,
                        itemBuilder: (context, position) {
                         return
                           ListTile(
                           leading: IconButton(
                             alignment: Alignment.centerLeft,
                               padding: EdgeInsets.zero,
                               onPressed: (){
                                 setState(() {
                                   provider.cartModelList[index].addonsList!.removeAt(position);
                                   Provider.of<ApplicationProvider>(context,
                                       listen: false)
                                       .updateProduct(provider.cartModelList[index],
                                       false,
                                       provider.cartModelList[index].enteredQty!);
                                 });
                               },
                               icon: Icon(Icons.remove_circle_outline,
                                 color: Colors.red,
                                 size: 20,)),
                           title: new Text(provider.cartModelList[index].addonsList![position].addonsSubTitleName.toString()),
                           trailing: Text('₹${provider.cartModelList[index].addonsList![position].addonsSubTitlePrice.toString()}'),
                           style: ListTileStyle.drawer,

                         );
                    }):Container()
                    ],
                  );
                }),
            // Padding(padding: EdgeInsets.only(top: 15), child: MySeparator()),
            // Container(
            //   height: 59,
            //   width: Helper.getScreenWidth(context) * 2,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(10),
            //         bottomRight: Radius.circular(10)),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Text("Write instruction for restaurant"),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(right: 10),
            //         child: Icon(Icons.add_circle_outline_outlined,
            //             size: 20, color: Colors.grey),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      );
    });
  }

}
