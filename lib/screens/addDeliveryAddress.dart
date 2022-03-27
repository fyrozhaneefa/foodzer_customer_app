import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
class AddDeliveryAddress extends StatefulWidget {
  String?  locality;
 AddDeliveryAddress(this.locality);

  @override
  _AddDeliveryAddressState createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {

  String? deliveryAddress ="";


  @override
  void initState() {
    // TODO: implement initState
    getDeliveryAddress();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
          padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
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
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'ADD YOUR ADDRESS DETAILS',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25,),
                  Flexible(
                    child: ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  widget.locality.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  deliveryAddress.toString(),
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3),
                                )
                            ),
                            SizedBox(height: 15,),
                            Container(
                              padding: EdgeInsets.all(8),
                              width: Helper.getScreenWidth(context),
                              decoration: BoxDecoration(
                                border:Border.all(color: Colors.orange.shade100,),
                                  borderRadius:
                                  BorderRadius.circular(5.0),
                                  color: Colors.orange[50]),
                              child: Text(
                                'A detailed address will help our Delivery Partner reach your doorstep easily',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepOrange[800],
                                  height: 1.3
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              textInputAction:  TextInputAction.next,
                              // controller: mobileController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                                  ),
                                  labelText: 'HOUSE / FLAT / BLOCK NO.',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                      color: Colors.grey
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction:  TextInputAction.next,
                              // controller: mobileController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.white,
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
                                  ),
                                  labelText: 'APARTMENT / ROAD / AREA (OPTIONAL)',
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              'DIRECTION TO REACH (OPTIONAL)',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                                textInputAction:  TextInputAction.done,
                                maxLength: 200,
                                // controller: msgtostudentController,
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "eg: Ring the bell on the red gate.",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400
                                      ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Colors.grey)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: Colors.grey)
                                    // width: 0.0 produces a thin "hairline" border
                                    // borderSide:  BorderSide(color: HexColor("#557EAE"), width: 0.0),
                                  ),
                                  // labelStyle: new TextStyle(color: HexColor("#557EAE")),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(200),
                                ]
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Container(
                        child:  Text("SAVE AND PROCEED",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary:Colors.deepOrange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            // side: BorderSide(color: Colors.grey)
                          )
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
  getDeliveryAddress() async{
    UserPreference().getDeliveryAddress().then((value)=>{
      setState(() {
        deliveryAddress = value;
      })
    });
  }
}
