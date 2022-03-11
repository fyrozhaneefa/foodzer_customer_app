import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/itemAddonModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RestaurantProductsList extends StatefulWidget {
  const RestaurantProductsList({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantProductsList> createState() => _RestaurantProductsListState();
}

class _RestaurantProductsListState extends State<RestaurantProductsList> {

  List<AddonModel> addonModelList=[];
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return  Consumer<ApplicationProvider>(
        builder: (context, provider, child) {
          return null!=provider.categoryBasedItemList? ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              physics: ScrollPhysics(),
              shrinkWrap: true,
              // itemCount: provider.selectedRestModel.items!.length,
              itemCount: provider.categoryBasedItemList.length,
              itemBuilder: (BuildContext context, int index) {
                // Item itemModel=provider.selectedRestModel.items![index];
                // String name=itemModel.categoryName!;
                Item itemModel = provider.categoryBasedItemList[index];
                return InkWell(

                  onTap: () {
                    singleItemDetails(context,itemModel);
                    provider.getItemId(itemModel.itemId!);
                    if(itemModel.isAddon == 1){
                      getAddons();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top:15,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    itemModel.itemVegNonveg=="1"?Image.asset(Helper.getAssetName("veg.png", "virtual"),
                                    height: 15,)
                                        :Image.asset(Helper.getAssetName("non-veg.png", "virtual"),
                                      height: 15,),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Text(itemModel.itemName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              height: 1.3)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              Text(itemModel.itemDescription!,
                                    style: TextStyle(
                                        color: Colors.grey.shade700)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('INR ${itemModel.itemPrice}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ],
                            ),
                            flex: 9,
                          ),
                          Expanded(
                            child: Container(
                              child: Image.network(
                                // 'https://i5.peapod.com/c/NY/NYO1E.png',
                                itemModel.itemImage!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            flex: 4,
                          )
                        ],
                      )),
                );
              }):Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),);
        }
    );
  }

  void singleItemDetails(context, Item itemModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        isScrollControlled: true,
        context: context,

        builder: (context) {
          bool valueFirst = true;
          int itemCount = 1;
          dynamic itemPrice = itemModel.itemPrice!;
          dynamic totalPrice =itemModel.itemPrice!;

          return StatefulBuilder(
           builder: (BuildContext context, setState) {

             return ListView(
               physics: ScrollPhysics(),
               shrinkWrap: true,
               // crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisSize: MainAxisSize.min,
               children: [
                 Stack(
                   children: [
                     Container(
                       width: Helper.getScreenWidth(context),
                       height: 200,
                       child: ClipRRect(
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(14),
                           topRight: Radius.circular(14),
                         ),
                         child: Image.network(
                           itemModel.itemImage!,
                           // 'https://mumbaimirror.indiatimes.com/photo/76424716.cms',
                           fit: BoxFit.fill,
                           height: double.infinity,
                           width: double.infinity,
                           alignment: Alignment.center,
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child:IconButton(
                         onPressed: (){
                           Navigator.of(context).pop();
                         },
                        icon:Icon(Icons.highlight_remove,
                          size: 35,
                          color: Colors.white,),
                       )
                     )
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Container(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(

                             itemModel.itemName!,
                             style: TextStyle(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 18
                             ),
                           ),
                           SizedBox(height: 10,),
                           Text(
                           itemModel.itemDescription!,
                             // 'Fried puff pastry balls, filled with spiced mashed potatoes and boondi. Served with spiced water and sweet tamarind sauce',
                             style: TextStyle(
                                 color: Colors.grey.shade600,
                                 height: 1.5,
                                 fontWeight: FontWeight.w500
                             ),
                           ),
                           null!=itemModel.itemDescription?SizedBox(height: 20,):SizedBox(),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                   'INR ${itemModel.itemPrice}',
                                   style:TextStyle(
                                       fontWeight: FontWeight.w600,
                                       fontSize: 16
                                   )
                               ),
                               Container(
                                 decoration:new  BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(12)),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey.shade400,
                                       blurRadius: 3.0,
                                       spreadRadius: 1.0,
                                     )
                                   ],
                                 ),
                                 child: Row(
                                   children: [
                                     IconButton(
                                       onPressed: () {
                                         if(itemCount == 0){
                                           Navigator.of(context).pop();
                                         } else {
                                           setState(() {
                                             itemCount--;
                                             totalPrice = double.parse(totalPrice.toString()) - double.parse(itemPrice.toString());
                                           });
                                         }
                                       },
                                       icon: Icon(Icons.remove,
                                         color: Colors.deepOrange,),
                                     ),
                                     SizedBox(width: 15,),
                                     Text(
                                       itemCount.toString(),
                                       style: TextStyle(
                                           fontWeight: FontWeight.w600
                                       ),
                                     ),
                                     SizedBox(width: 15,),
                                     IconButton(
                                       onPressed: () {
                                         setState(() {
                                          itemCount++; //_two => TextEditingController of 2nd TextField
                                          totalPrice = double.parse(totalPrice.toString()) + double.parse(itemPrice.toString());
                                         });
                                       },
                                       icon: Icon(Icons.add,
                                         color: Colors.deepOrange,),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ],
                       )
                   ),
                 ),
                 Divider(height: 15,thickness: 6,color: Colors.grey.shade300),

                 null!=Provider.of<ApplicationProvider>(context ,listen: false).addonModelList && Provider.of<ApplicationProvider>(context ,listen: false).addonModelList.length>0?
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Text("Add On's:",
                               style: TextStyle(
                                   fontWeight: FontWeight.w600,
                                   fontSize: 16
                               )
                           ),
                           Text(
                             '(optional)',
                               style: TextStyle(
                                 color: Colors.grey,

                               )
                           )
                         ],
                       ),
                       SizedBox(
                         height: 10,),
                        Text(
                           'Choose items from the list',
                             style: TextStyle(
                               fontWeight: FontWeight.w600,
                               color: Colors.grey,
                               fontSize: 14
                             )
                       ),
                       SizedBox(height: 30,),
                       ListView.separated(
                           separatorBuilder: (context, index) {
                             return Divider();
                           },
                           physics: ScrollPhysics(),
                           shrinkWrap: true,
                         itemCount: Provider.of<ApplicationProvider>(context ,listen: false).addonModelList.length,
                           itemBuilder: (context, index) {
                                                        return Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                     Provider.of<ApplicationProvider>(context ,listen: false).addonModelList[index].addonsSubTitleName.toString()
                                 ),
                                 Row(
                                   children: [
                                     Text(
                                       '(+ INR ${Provider.of<ApplicationProvider>(context ,listen: false).addonModelList[index].addonsSubTitlePrice})'
                                     ),
                                     Checkbox(
                                       checkColor: Colors.greenAccent,
                                       activeColor: Colors.red,
                                       value: Provider.of<ApplicationProvider>(context ,listen: false).addonModelList[index].isSelected,
                                     onChanged: (bool? value){
                                       setState(() {
                                         Provider.of<ApplicationProvider>(context ,listen: false).addonModelList[index].isSelected = !value!;
                                       });
                                     },
                                     ),
                                   ],
                                 )
                               ],
                             );
                           })
                     ],
                   ),
                 ):Container(),
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         child: Row(
                           children: [
                             Icon(
                               Icons.messenger_outline
                             ),
                             SizedBox(width: 10,),
                             Text(
                               'Any special requests?',
                               style: TextStyle(
                                 fontSize: 15,
                                   fontWeight: FontWeight.w600
                               ),
                             ),
                           ],
                         ),
                       ),
                       GestureDetector(
                         onTap: () => addNote(context),
                         child: Text(
                           'Add note',
                           style: TextStyle(
                             color: Colors.deepOrange,
                             fontWeight: FontWeight.w600
                           ),
                         ),
                       )
                     ],
                   )
                 ),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     height: 60,
                     child: ElevatedButton(
                       onPressed: (){

                       },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             'Add to basket',
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w700
                             ),
                           ),
                           Text(
                             'INR '+ totalPrice.toStringAsFixed(2),
                             style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w700
                             ),
                           )
                         ],
                       ),
                       style: ElevatedButton.styleFrom(
                           primary:Colors.deepOrange,
                           elevation: 0,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12.0),
                             // side: BorderSide(color: Colors.grey)
                           )
                       ),
                     ),
                   ),
                 )
               ],
             );
           },
         );
        });
  }

 void addNote(context) {
   showModalBottomSheet(
       isScrollControlled:true,
       context: context,
       builder: (context) {
         return Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Special request'),
                  SizedBox(height: 20,),
                  TextField(
                    maxLength: 200,
                    decoration: InputDecoration(
                      fillColor: Colors.deepOrange,
                      hintText: "No onions please...",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      suffixIcon: Icon(Icons.highlight_remove_outlined,
                      color: Colors.black,)
                    ),
                  ),
                ],
               ),
             ),
             Container(
               padding: EdgeInsets.all(15),
                 width: Helper.getScreenWidth(context),
                 color: Colors.grey.shade300,
                 child:GestureDetector(
                   onTap: (){
                     Navigator.of(context).pop();
                   },
                   child: Text(
                       'Done',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w600
                     ),
                     textAlign: TextAlign.end,
                   ),
                 )
             )
           ],
         );
       }
       );
 }

  getAddons() async {
    var map = new Map<String, dynamic>();
    map['item_id'] = Provider.of<ApplicationProvider>(context ,listen: false).itemId;
    var response= await http.post(Uri.parse(ApiData.GET_ITEM_ADDONS),body:map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['addons'];
    if(null!= dataList && dataList.length >0){
      addonModelList =dataList.map((spacecraft) => new AddonModel.fromJson(spacecraft)).toList();
      Provider.of<ApplicationProvider>(context ,listen: false).setItemAddons(addonModelList);
      setState(() {

      });
    }


  }
}
