import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  bool isSwitchView = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All restaurants',
        style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.w700),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                        child: GestureDetector(
                          onTap: (){
                            isSwitchView = true;
                            setState(() {

                            });
                          },
                            child: Icon(
                              Icons.list,
                              color: isSwitchView ? Colors.deepOrange:Colors.black,)
                        ),
                      ),
                      VerticalDivider(thickness: 1,color: Colors.grey.shade300),
                      Container(
                        margin: const EdgeInsets.only(left: 10.0,right: 10,top: 5,bottom: 5),
                        child: GestureDetector(
                            onTap: (){
                              isSwitchView = false;
                              setState(() {

                              });
                            },
                            child: Icon(Icons.view_agenda_outlined,
                            color: isSwitchView ? Colors.black:Colors.deepOrange,)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 30,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                print(index);
              },
              child: isSwitchView? Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      width: 70,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                        child: Image.network(
                            'https://cdn.shopify.com/s/files/1/0508/9368/4926/files/TofuHouseLogo_2820x.png?v=1604899681',
                        fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(child: ProductDesc())
                  ],
                ),
              ):Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                      Container(
                        margin:EdgeInsets.only(bottom: 10),
                        width: Helper.getScreenWidth(context),
                        height:150,
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://png.pngtree.com/thumb_back/fh260/back_our/20190620/ourmid/pngtree-food-seasoning-food-banner-image_169169.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ProductDesc()
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class ProductDesc extends StatelessWidget {
  const ProductDesc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Healthy Calorie, Zayed Town',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 3,),
        Text(
          'Health, Sandwiches, International',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.tag_faces,
              color: Colors.orangeAccent,
              size: 20,
            ),
            SizedBox(width: 5,),
            Text(
                'Amazing'
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
                Icons.access_time,
              size: 20,
            ),
            SizedBox(width: 5,),
            Text(
                'Within 30 mins',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(width: 5,),
            Container(
              child: CircleAvatar(
                radius: 2,
                backgroundColor: Colors.grey.shade400,
              ),
            ),
            SizedBox(width: 5,),
            Icon(
              Icons.delivery_dining,
              color: Colors.grey.shade900,
              size: 20,
            ),
            Text(
              'BD 0.400',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    );
  }
}
