import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/applybutton.dart';


import '../FavoriteSection/itemCard.dart';

class OfferSection extends StatelessWidget {
  const OfferSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.keyboard_backspace_outlined, color: Colors.black),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          text: TextSpan(
              text: "Home",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              children: [
                WidgetSpan(
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.black))
              ]),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Featured Offers",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ItemCard(
            itemImage:
                "https://i.pinimg.com/originals/b6/c2/5b/b6c25bbeccd4dabcaf79c2b301747d3f.jpg",
            itemName: "KFC",
          ),
          ItemCard(
            itemImage:
                "https://assets.cntraveller.in/photos/60ba26c0bfe773a828a47146/master/pass/Burgers-Mumbai-Delivery.jpg",
            itemName: "Burger Lounge-Beach Road",
          ),
          ItemCard(
            itemImage:
                "https://st.depositphotos.com/1003814/5052/i/950/depositphotos_50523105-stock-photo-pizza-with-tomatoes.jpg",
            itemName: "Cafe Pizza Corner",
          ),
          ItemCard(
            itemImage:
                "https://www.vegrecipesofindia.com/wp-content/uploads/2018/09/vegetable-noodles.jpg",
            itemName: "Chicken Noodles",
          ),
          ItemCard(
            itemImage:
                "https://www.whiskaffair.com/wp-content/uploads/2018/11/Vegetable-Fried-Rice-2-3.jpg",
            itemName: "Fried Rice",
          ),
          ItemCard(
            itemImage:
                "https://static.toiimg.com/thumb/53991492.cms?imgsize=97707&width=800&height=800",
            itemName: "Cutlet",
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: ApplyButton(buttonname: "VIEW ALL", radius: 7),
          )
        ],
      ),
    );
  }
}
