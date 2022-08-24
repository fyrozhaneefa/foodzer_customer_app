import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/net_banking.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/PaymentSection/wallets.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'Constants/sapperator.dart';

class MorePayment extends StatefulWidget {
  int? delType;
 MorePayment(this.delType);

  @override
  State<MorePayment> createState() => _MorePaymentState();
}

class _MorePaymentState extends State<MorePayment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height:320,


        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Wallets(widget.delType)));
                },
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Wallets",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                    height: 30,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Card(
                        child: Image(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThbJ4qVoBHcsxlMa0A6l6tur1hK81XpY7epMVrwTNnF8veMVuQWJLhv04SDklD8VYGZXw&usqp=CAU"))),
                  ),
                  subtitle: Text(
                    "Paytm,PhonePe,Amazone Pay & more",
                    style: TextStyle(fontSize: 11),
                  ),
                trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),),
              MySeparator(),
              ListTile(
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "Currently not available",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepOrangeAccent,
                      textColor: Colors.white,
                      fontSize: 14.0);

                },
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Food Cards",
                    style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey),
                  ),
                ),
                leading: Container(
                  height: 33,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Card(
                      child: Image(
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/865/865376.png"))),
                ),
                subtitle: Text(
                  // "Food Card to be used only for restaurant..",
                  "Currenlty not available",
                  style: TextStyle(fontSize: 11),
                ),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),
              ),
              MySeparator(),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NetBanking(widget.delType)));
                },
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Netbanking",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                    height: 33,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Card(
                        child: Image(
                            image: NetworkImage(
                                "https://d338t8kmirgyke.cloudfront.net/icons/icon_pngs/000/001/780/original/bank.png"))),
                  ),
                  subtitle: Text(
                    "Select from a list of banks",
                    style: TextStyle(fontSize: 11),
                  ),
                trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,), ),
              MySeparator(),
              ListTile(
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "Currently not available",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepOrangeAccent,
                      textColor: Colors.white,
                      fontSize: 14.0);
                },
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "CRED pay",
                    style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey),
                  ),
                ),
                leading: Container(
                  height: 33,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Card(
                      child: Image(
                          image: NetworkImage(
                              "https://pbs.twimg.com/profile_images/1168783954985414656/jr3zLavO_400x400.jpg"))),
                ),
                subtitle: Text(
                  // "10% upto Rs.50 off with your credit card",
                  "Currenlty not available",
                  style: TextStyle(fontSize: 11),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),  ),

            ],
          ),
        ),
      ),
    );
  }
}
