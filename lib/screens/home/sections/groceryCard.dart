import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class GroceryCard extends StatelessWidget {
  final String cardName,cardTime,cardType,cardSubType,rating,deliveryCharge,bannerName,discount;
  final press;
  const GroceryCard({
    Key? key,
    // required this.cardBanner,
    required this.cardName,
    required this.cardTime,
    required this.cardType,
    required this.cardSubType,
    required this.rating,
    required this.deliveryCharge,
    required this.bannerName,
    required this.discount,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(bottom: 30),
          width: Helper.getScreenWidth(context)*0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10,right:10),
                height: 125,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    bannerName,
                     fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Helper.getScreenWidth(context)*0.45,
                          child: Text(
                            cardName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time_outlined,
                            color: Colors.deepOrange,
                            size: 20,),
                          SizedBox(width: 5,),
                          Text(
                            'Within'+' '+cardTime+' ''mins',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Container(
                child:   Text(
                    cardType+','+' '+cardSubType
                ),
              ),
              SizedBox(height: 8,),
              Container(
                  child:  Row(
                    children: [
                      Icon(Icons.tag_faces_outlined),
                      SizedBox(width: 5,),
                      Text(rating,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),),
                      SizedBox(width: 25,),
                      Text('Delivery:'+' '+deliveryCharge,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),),
                    ],
                  )
              ),
              SizedBox(height: 5,),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.local_offer_outlined,
                    size: 20,
                    color: Colors.pinkAccent,),
                    SizedBox(width: 5,),
                    Text(discount+' '+'selected items',
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w600
                      ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}