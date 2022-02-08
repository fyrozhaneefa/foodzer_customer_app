import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class AllFlowersScreen extends StatefulWidget {
  static const routeName = "/AllFlowersScreen";
  const AllFlowersScreen({Key? key}) : super(key: key);

  @override
  _AllFlowersScreenState createState() => _AllFlowersScreenState();
}

class _AllFlowersScreenState extends State<AllFlowersScreen> {
  bool isSwitchView = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back,
            color: Colors.black,
            size: 30,),
        ),
        centerTitle: true,
        title:Column(
          children: [
            Text(
              'Delivering to',
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Al Hilal West',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.deepOrange,)
              ],
            )
          ],
        ),
        bottom: PreferredSize(
          child:Column(
            children: [
              Divider(thickness: 1,),
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15,bottom: 10),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.filter_list,
                              size: 25,),
                            SizedBox(width: 10,),
                            Text(
                              'Filters',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1,),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.search_outlined),
                            SizedBox(width: 10,),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size(0.0, 50.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All stores',
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
                                  'https://d1h79zlghft2zs.cloudfront.net/uploads/2019/07/2285-768x1004.png',
                                  fit: BoxFit.contain,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Quickly Flowers',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.celebration,
                                        color: Colors.deepOrangeAccent,),
                                      SizedBox(width: 5,),
                                      Text(
                                        'Within 30 mins',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 3,),
                            Text(
                              'Flowers',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
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
                                ),
                                SizedBox(width: 5,),
                                Text(
                                    'Amazing'
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                    'Delivery: 10.00'
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child: CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                    'Min: 0.00'
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      )
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
          'Quickly Flowers',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 5,),
        Text(
          'Flowers',
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.tag_faces,
              color: Colors.orangeAccent,
            ),
            SizedBox(width: 5,),
            Text(
                'Amazing'
            ),
          ],
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            Text(
              'Within 30 mins',
              style: TextStyle(
                fontSize: 12
              ),
            ),
            SizedBox(width: 10,),
            Text(
              'Delivery: 10.00',
              style: TextStyle(
                  fontSize: 12
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Text(
          'Min: 0.00',
          style: TextStyle(
              fontSize: 12
          ),
        )
      ],
    );
  }
}
