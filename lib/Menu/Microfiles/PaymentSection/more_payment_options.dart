import 'package:flutter/material.dart';
import 'Constants/sapperator.dart';

class MorePayment extends StatelessWidget {
  const MorePayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        height: height / 1.2,


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
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Food Cards",
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
                              "https://cdn-icons-png.flaticon.com/512/865/865376.png"))),
                ),
                subtitle: Text(
                  "Food Card to be used only for restaurant..",
                  style: TextStyle(fontSize: 11),
                ),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,),
              ),
              MySeparator(),
              ListTile(
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
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "CRED pay",
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
                              "https://pbs.twimg.com/profile_images/1168783954985414656/jr3zLavO_400x400.jpg"))),
                ),
                subtitle: Text(
                  "10% upto Rs.50 off with your credit card",
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
