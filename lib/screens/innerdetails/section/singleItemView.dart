import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/Models/itemAddonModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/basket/Section/itemBasketHome.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class SingleItemView extends StatefulWidget {
  Item itemModel;
 SingleItemView(this.itemModel);

  @override
  _SingleItemViewState createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView> {
  // List<bool> isChecked = List.generate(
  //     Provider.of<ApplicationProvider>(context, listen: false)
  //         .addonModelList
  //         .length,
  //         (index) => false);
  bool isIncrement = false;
  int itemCount = 1;
  dynamic itemPrice;
  dynamic totalPrice;
  bool isChecked = false;
  List<Addons> addonModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    if(null!=widget.itemModel.enteredQty && null!=widget.itemModel.itemPrice){
      totalPrice= widget.itemModel.itemPrice! * widget.itemModel.enteredQty!;
    } else {
      totalPrice = widget.itemModel.itemPrice!;
    }
    if(null!=widget.itemModel.enteredQty  ){
      itemCount = widget.itemModel.enteredQty!;
    }
    if (widget.itemModel.isAddon == 1) {
      getAddons();
    }
    itemPrice = widget.itemModel.itemPrice!;
    // totalPrice = widget.itemModel.itemPrice!;

    setState(() {

    });

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return isLoading?Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),):Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),),
          Flexible(
            child: ListView(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
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
                      widget.itemModel.itemImage!,
                      // 'https://mumbaimirror.indiatimes.com/photo/76424716.cms',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemModel.itemName!,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.itemModel.itemDescription!,
                            // 'Fried puff pastry balls, filled with spiced mashed potatoes and boondi. Served with spiced water and sweet tamarind sauce',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                          null != widget.itemModel.itemDescription
                              ? SizedBox(
                            height: 20,
                          )
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('INR $totalPrice',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16)),
                              Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                                        if (itemCount == 1) {
                                          // Navigator.of(context).pop();
                                        } else {
                                          setState(() {
                                            itemCount--;
                                            totalPrice = double.parse(
                                                totalPrice.toString()) -
                                                double.parse(
                                                    itemPrice.toString());
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: itemCount == 1?Colors.deepOrange.shade100:Colors.deepOrange,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(

                                        itemCount.toString(),
                                      style:
                                      TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          itemCount++; //_two => TextEditingController of 2nd TextField
                                          totalPrice = double.parse(
                                              totalPrice.toString()) +
                                              double.parse(itemPrice.toString());
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                null !=addonModelList && addonModelList.length >0
                    ? Divider(
                    height: 15, thickness: 6, color: Colors.grey.shade300):Container(),
                null !=addonModelList && addonModelList.length >0
                    ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Add On's:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                          Text('(optional)',
                              style: TextStyle(
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Choose items from the list',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: 14)),
                      SizedBox(
                        height: 30,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addonModelList.length,
                          itemBuilder: (context, index) {
                            return Row(
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
                                                if(addonModelList[index].isSelected == true){
                                                  totalPrice = double.parse(
                                                      totalPrice.toString()) +
                                                      double.parse(addonModelList[index].addonsSubTitlePrice.toString());
                                                } else {
                                                  totalPrice = double.parse(
                                                      totalPrice.toString()) -
                                                      double.parse(addonModelList[index].addonsSubTitlePrice.toString());
                                                }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          })
                    ],
                  ),
                )
                    : Container(),
                Divider(
                    height: 15, thickness: 6, color: Colors.grey.shade300),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.messenger_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Any special requests?',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
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
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  widget.itemModel.addonsList=addonModelList.where((element) => element.isSelected == true).toList();

                  Provider.of<ApplicationProvider>(context,
                      listen: false)
                      .updateProduct(widget.itemModel,
                      null==widget.itemModel.enteredQty || null!=widget.itemModel.enteredQty && itemCount > widget.itemModel.enteredQty!,
                      itemCount);
                  Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) =>
                  //         ItemBasketHome()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      null!=widget.itemModel.enteredQty && widget.itemModel.enteredQty! > 0?'Update basket'
                          :
                      'Add to basket',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'INR ' + totalPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    )
                  ],
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
          )
        ],
      ),
    );
  }

  void addNote(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          TextEditingController itemNoteController =
          new TextEditingController();
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
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: itemNoteController,
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
                          suffixIcon: Icon(
                            Icons.highlight_remove_outlined,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  width: Helper.getScreenWidth(context),
                  color: Colors.grey.shade300,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Done',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                  ))
            ],
          );
        });
  }
  getAddons() async {
    isLoading =true;
    setState(() {

    });
    var map = new Map<String, dynamic>();
    map['item_id'] =
       widget.itemModel.itemId!;
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
             totalPrice = double.parse(
                 totalPrice.toString()) +  addonModel.addonsSubTitlePrice!;
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
