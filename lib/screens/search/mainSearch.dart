import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class MainSearchScreen extends StatefulWidget {
  static const routeName = "/mainSearch";
  const MainSearchScreen({Key? key}) : super(key: key);

  @override
  State<MainSearchScreen> createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            size: 26,
            color: Colors.black,)
          , onPressed: () {
            Navigator.pop(context);
        },),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: 45,
            child: Container(
              child: TextField(
                textInputAction:TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for restaurants or ...',
                  prefixIcon: Icon(Icons.search,
                    color: Colors.black,),
                ),
              ),
            ),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:  Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Helper.getScreenWidth(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Popular searches',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                  ),
                ),
                SizedBox(height: 20,),
          Container(
            height: 200,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio:16/9,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: InkWell(
                    onTap: (){
                      print('printed');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border:  Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8).copyWith(top: 0,bottom: 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timeline,
                              color: Colors.grey,
                              size: 16,
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                'shawarma',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 40,),
                Container(
                  child: Text(
                    'Featured restaurants',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/1/1e/RPC-JP_Logo.png'),
                          radius: 40,
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
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
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    'Amazing'
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    child: CircleAvatar(
                                      radius: 2,
                                      backgroundColor: Colors.grey.shade400,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(
                                    Icons.attach_money,
                                    color: Colors.grey.shade400,
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Within 30 mins',
                                    style: TextStyle(
                                      fontSize: 12
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    child: CircleAvatar(
                                      radius: 2,
                                      backgroundColor: Colors.grey.shade400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.delivery_dining,
                                    color: Colors.grey.shade900,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
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
                          ),
                        )
                      ],
                    ),
                  );
                    },

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
