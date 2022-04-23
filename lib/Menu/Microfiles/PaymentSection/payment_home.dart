import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/Constants/images.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/addNewCard.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/more_payment_options.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/pay_on_delivery.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/recommented_payment.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/upi.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import 'Constants/sizedbox.dart';



class PaymentSection extends StatefulWidget {
  int delType;
  PaymentSection(this.delType);

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(builder: (context, provider, child) {
      return Scaffold(
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
                  "Payment Option",
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
                      "Total:₹${provider.totalCartPrice}",
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
          body: SafeArea(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                    widget.delType == 1? ListTile(
                        leading:
                            Container(child: Image(image: AssetImage(Track))),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                provider.selectedRestModel.branchDetails!.merchantBranchName.toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(" | "),
                              Text("Delivery in : 52 min",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                              ),)
                            ],
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              provider.selectedAddressModel.addressTitle.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                            Text(" | "),
                            Expanded(
                              child: Text(provider.selectedAddressModel.addressBuilding.toString()+", "+
                                provider.selectedAddressModel.adressApartmentNo.toString()+", "+
                                provider.selectedAddressModel.addressStreetName.toString()+", "+
                                provider.selectedAddressModel.currentAddressLine.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontSize: 12
                              ),),
                            )
                          ],
                        ),
                      ):ListTile(

                   title: Row(
                        children: [
                          Text(
                            provider.selectedRestModel.branchDetails!.merchantBranchName.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(" | "),
                          Text("Delivery type : ${widget.delType ==2 ? "Pickup":"Delivery"}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),)
                        ],
                      ),
                    ),
                    ],
                  ),
                ),
                SizedWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Pay on Delivery ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                PayonDelivery(),
                SizedWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Credit & Debit cards ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                            AddNewCard(widget.delType)));

                        // buttonClick();
                        // Payment();
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: ListTile(
                          subtitle: Text(
                            "Save and Pay via Cards.",
                            style: TextStyle(fontSize: 11),
                          ),
                          title: Text(
                            "Add New Card",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w600),
                          ),
                          leading: Container(
                            height: 24,
                            width: 35,
                            child: Icon(
                              Icons.add,
                              size: 15,
                              color: Colors.deepOrange,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                          ),
                        ),
                      ),
                    )),
                SizedWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "UPI",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                UpiSection(widget.delType),
                SizedWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "More Payment Options",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                MorePayment(),
                SizedWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Recommended Payments",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                RecommededPayments(),
              ],
            ),
          ),
          backgroundColor: Colors.blueGrey[50]);
    });
  }
}
