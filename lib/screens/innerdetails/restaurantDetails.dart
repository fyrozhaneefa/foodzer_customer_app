import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/DetailSearch/detailsearch.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/divider.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/ReviewSection/review_section.dart';
import 'package:foodzer_customer_app/Models/SingleRestModel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/restaurants.dart';
import 'package:foodzer_customer_app/screens/allrestaurants/section/shimmer/shimmerwidget.dart';
import 'package:foodzer_customer_app/screens/innerdetails/restaurantInfo.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/persistantHeader.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategory.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/productCategoryItem.dart';
import 'package:foodzer_customer_app/screens/innerdetails/section/restaurantProductsList.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:foodzer_customer_app/utils/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
import 'package:provider/provider.dart';
import '../../Menu/Microfiles/ReviewSection/review.dart';
import '../../Models/restaurentmodel.dart';
import '../basket/Section/itemBasketHome.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  static const routeName = "/restaurantDetails";
  String? merchantBranchId, lat, lng;

  RestaurantDetailsScreen(
    this.merchantBranchId,
    this.lat,
    this.lng,
  );

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen>
    with TickerProviderStateMixin {
  bool isSwitched = false;
  bool isLoading = true;
  bool isRestContainItems = false;
  int? loadedItemCount;

  List<Item> filteredList = [];
  List<Item> filteredLoadedProductModelList = [];
  TabController? tabController;

  @override
  void dispose() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ApplicationProvider>(context, listen: false)
          .setCurrentRestModel(new SingleRestModel());
    });
    super.dispose();
  }

  @override
  void initState() {
    getRestDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rectangular(
                  height: 150,
                  width: Helper.getScreenWidth(context),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: ShimmerWidget.rectangular(
                      height: 20,
                      width: 250,
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ShimmerWidget.rectangular(
                      height: 20,
                      width: 100,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: ShimmerWidget.rectangular(
                        height: 20,
                        width: 180,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10, top: 20),
                      child: ShimmerWidget.rectangular(
                        height: 20,
                        width: 90,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 30),
                  child: ShimmerWidget.rectangular(
                    height: 30,
                    width: 180,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 10),
                  child: ShimmerWidget.rectangular(
                    height: 40,
                    width: Helper.getScreenWidth(context),
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: ShimmerWidget.rectangular(
                        height: 30,
                        width: 100,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: ShimmerWidget.rectangular(
                        height: 30,
                        width: 120,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: ShimmerWidget.rectangular(
                        height: 30,
                        width: 100,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 2),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 20),
                  child: ShimmerWidget.rectangular(
                    height: 30,
                    width: 180,
                  ),
                ),
                Expanded(
                    child: ListView.separated(separatorBuilder: (context,index){

                      return Divider();
                    },
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: ShimmerWidget.rectangular(
                                  height: 20,
                                  width: 100,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ShimmerWidget.rectangular(
                                      height: 20,
                                      width: 180,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    child: ShimmerWidget.rectangular(
                                      height: 80,
                                      width: 80,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ));
                        }

                        )
                )
              ],
            )
          : Consumer<ApplicationProvider>(builder: (context, provider, child) {
              return Stack(
                children: [
                  !isRestContainItems
                      ? Center(child: Text("No item found"))
                      : CustomScrollView(
                          // scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              elevation: 0,
                              expandedHeight: 150,
                              backgroundColor: Colors.white,
                              pinned: true,
                              leading: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
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
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, top: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchDetails()));
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              centerTitle: true,
                              title: Text(
                                null != provider.selectedRestModel.branchDetails
                                    ? provider.selectedRestModel.branchDetails!
                                        .merchantBranchName!
                                    : "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.parallax,
                                background: Image.network(
                                  null !=
                                          provider
                                              .selectedRestModel
                                              .branchDetails!
                                              .merchantBranchCoverImage
                                      ? provider
                                          .selectedRestModel
                                          .branchDetails!
                                          .merchantBranchCoverImage!
                                      : provider.selectedRestModel
                                          .branchDetails!.merchantBranchImage!,

                                  // _singleRestModel.branchDetails!.merchantBranchImage!,
                                  // 'https://cdn-prod.medicalnewstoday.com/content/images/articles/314/314819/delicious-buffet-foods.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 10,
                                    top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            // Provider.of<ApplicationProvider>(context ,listen: false).selectedRestModel.branchDetails!.merchantBranchName!,
                                            provider
                                                .selectedRestModel
                                                .branchDetails!
                                                .merchantBranchName!,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        RestaurantInfoScreen(
                                                            provider
                                                                .selectedRestModel)));
                                          },
                                          child: Text(
                                            'Info',
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(provider
                                        .selectedRestModel.branchCuisine!),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          null !=
                                                      provider.selectedRestModel
                                                          .reviews!.numOfRows &&
                                                  provider.selectedRestModel
                                                          .reviews!.numOfRows ==
                                                      0
                                              ? Icons.sentiment_dissatisfied
                                              : Icons.tag_faces,
                                          color: null !=
                                                      provider.selectedRestModel
                                                          .reviews!.numOfRows &&
                                                  provider.selectedRestModel
                                                          .reviews!.numOfRows ==
                                                      0
                                              ? Colors.yellow[600]
                                              : Colors.grey.shade700,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10),
                                        RichText(
                                          text: new TextSpan(
                                            children: [
                                              TextSpan(
                                                text: null !=
                                                            provider
                                                                .selectedRestModel
                                                                .reviews!
                                                                .numOfRows &&
                                                        provider
                                                                .selectedRestModel
                                                                .reviews!
                                                                .numOfRows ==
                                                            0
                                                    ? "No review yet "
                                                    : provider
                                                        .selectedRestModel
                                                        .reviews!
                                                        .branchAvgRating
                                                        .toString(),
                                                style: new TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              new TextSpan(
                                                text:
                                                    'Based on (${provider.selectedRestModel.reviews!.numOfRows}) ratings ',
                                                style: new TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ReviewRestaurent()));
                                            },
                                            child: Text(
                                              'Reviews',
                                              style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.grey.shade700,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10),
                                        RichText(
                                          text: new TextSpan(
                                            children: [
                                              new TextSpan(
                                                text:
                                                    'Within ${provider.selectedRestModel.branchDetails!.merchantBranchOrderTime} mins ',
                                                style: new TextStyle(
                                                    color: Colors.black),
                                              ),
                                              // new TextSpan(
                                              //   text:
                                              //       '(${provider.selectedRestModel.branchDetails!.countryCurrency} 0.590 delivery) ',
                                              //   style: new TextStyle(
                                              //       fontSize: 12,
                                              //       color: Colors.grey),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_offer_outlined,
                                          color: Colors.pinkAccent,
                                          size: 25,
                                        ),
                                        SizedBox(width: 10),
                                        Text('2 RO Off Orders 7 Rials or More!',
                                            style: TextStyle(
                                              color: Colors.pinkAccent,
                                              fontWeight: FontWeight.w500,
                                            ))
                                      ],
                                    ),
                                    Divider(
                                      height: 25,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      width: Helper.getScreenWidth(context),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          color: Colors.grey.shade100),
                                      child: Text(
                                        'Delivered by us, with live tracking',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    // ProductCategoryItem(widget.merchantBranchId,
                                    //     widget.lat, widget.lng),
                                  ],
                                ),
                              )
                            ])),
                            SliverPersistentHeader(
                                pinned: true,
                                floating: false,
                                delegate: PersistentHeader(
                                    TabBar(
                                      indicatorWeight: 2.0,
                                      onTap: (int val) {
                                        VerticalScrollableTabBarStatus.setIndex(
                                            val);
                                      },
                                      // physics: const AlwaysScrollableScrollPhysics(),
                                      isScrollable: true,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.black,
                                      indicatorColor: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      controller: tabController,
                                      indicator: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      tabs: provider.categoryList
                                          .map((t) => Tab(
                                                text: t.categoryName,
                                              ))
                                          .toList(),
                                    ),
                                    tabController!

                                    // pinned: true,
                                    )),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       'VEG',
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.w600),
                                    //     ),
                                    //     Switch(
                                    //       value: isSwitched,
                                    //       onChanged: (value) {
                                    //         setState(() {
                                    //           isSwitched = value;
                                    //         });
                                    //       },
                                    //       activeTrackColor: Colors.green.shade100,
                                    //       activeColor: Colors.green.shade300,
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    RestaurantProductsList(
                                        isSwitched, tabController),
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                  ],
                                ),
                              ),
                            ]))
                          ],
                        ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: Container(
                          height: 0,
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (provider.cartModelList.length > 0) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ItemBasketHome()))
                                .then((value) {
                              if (provider.selectedCategoryId == 0) {
                                filteredList =
                                    provider.selectedRestModel.items!;
                                filteredList.sort((a, b) =>
                                    a.categoryName!.compareTo(b.categoryName!));
                              } else {
                                filteredList = provider.selectedRestModel.items!
                                    .where((product) => (product.categoryId ==
                                        provider.selectedCategoryId!))
                                    .toList();
                                filteredList.sort((a, b) =>
                                    a.categoryName!.compareTo(b.categoryName!));
                              }
                              // Provider.of<ApplicationProvider>(context, listen: false).clearItems();
                              Provider.of<ApplicationProvider>(context,
                                      listen: false)
                                  .setItemLoading(true);
                              loadedItemCount = 0;
                              _loadData();
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2, //
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        provider.cartModelList.length
                                            .toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'View basket',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    null != provider.totalWithoutTax
                                        ? '₹${provider.totalWithoutTax}'
                                        : "₹0",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: provider.cartModelList.length > 0
                              ? Colors.deepOrange
                              : Colors.deepOrange.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
    ));
  }

  getRestDetails() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['merchant_branch_id'] = widget.merchantBranchId;
    map['lat'] = widget.lat;
    map['lng'] = widget.lng;
    var response = await http.post(Uri.parse(ApiData.SINGLE_REST), body: map);
    var json = convert.jsonDecode(response.body);
    if (json['error_code'] == 0) {
      SingleRestModel _singleRestModel = new SingleRestModel();
      _singleRestModel = SingleRestModel.fromJson(json);
      List<Category> categoryList = [];
      categoryList = _singleRestModel.categories!;
      if (null != categoryList && categoryList.length > 0) {
        Provider.of<ApplicationProvider>(context, listen: false)
            .setCategoryName(categoryList.first.categoryName!);
        tabController = TabController(length: categoryList.length, vsync: this);
        isRestContainItems = true;
        tabController!.addListener(() {
          setState(() {
            // selectedIndex = tabController!.index;
          });
        });
        setState(() {});
      } else {
        // tabController = TabController(length: 1, vsync: this);
        // categoryList.add(new Category(categoryName: "",categoryId: 0));
        isRestContainItems = false;
      }
      Provider.of<ApplicationProvider>(context, listen: false)
          .setCategoryList(categoryList);

      Provider.of<ApplicationProvider>(context, listen: false)
          .setCurrentRestModel(_singleRestModel);
      Provider.of<ApplicationProvider>(context, listen: false)
          .addProductData(_singleRestModel.items!, true);

      isLoading = false;
      setState(() {});
      // Provider.of<ApplicationProvider>(context ,listen: false).filterItems(_singleRestModel.items![0].categoryId!);
      // Provider.of<ApplicationProvider>(context ,listen: false).setCategoryName(_singleRestModel.categories![0].categoryName!);
    } else {
      isLoading = false;
      setState(() {});
    }
  }

  Future _loadData() async {
    int endIndex = 7;
    // perform fetching data delay
    if (Provider.of<ApplicationProvider>(context, listen: false)
            .isItemLoading &&
        null != filteredList &&
        filteredList.length > 0) {
      await new Future.delayed(new Duration(seconds: 1));

      setState(() {
        if (loadedItemCount! <= filteredList.length) {
          if (loadedItemCount! + endIndex <= filteredList.length) {
            Provider.of<ApplicationProvider>(context, listen: false)
                .filteredLoadedProductModelList
                .addAll(filteredList.getRange(
                    loadedItemCount!, loadedItemCount! + endIndex));
            Provider.of<ApplicationProvider>(context, listen: false)
                .setItemLoading(false);
            loadedItemCount = loadedItemCount! + endIndex;
          } else {
            endIndex = filteredList.length - loadedItemCount!;
            Provider.of<ApplicationProvider>(context, listen: false)
                .filteredLoadedProductModelList
                .addAll(filteredList.getRange(
                    loadedItemCount!, loadedItemCount! + endIndex));
            Provider.of<ApplicationProvider>(context, listen: false)
                .setItemLoading(false);
            loadedItemCount = loadedItemCount! + 7;
          }
        } else {
          Provider.of<ApplicationProvider>(context, listen: false)
              .setItemLoading(false);
        }
      });
    }
  }

  // getItemCategory() async {
  //   var map = new Map<String, dynamic>();
  //   map['merchant_branch_id'] = widget.merchantBranchId;
  //   map['lat'] = widget.lat;
  //   map['lng'] = widget.lng;
  //   var response = await http.post(Uri.parse(ApiData.SINGLE_REST), body: map);
  //   var json = convert.jsonDecode(response.body);
  //
  //
  //   if (json['error_code'] == 0) {
  //     List dataList = json['categories'];
  //
  //     if (null != dataList && dataList.length > 0) {
  //       categoryList = dataList
  //           .map((spacecraft) => new Category.fromJson(spacecraft))
  //           .toList();
  //       // categoryList.insert(
  //       //     0, new Category(categoryId: 0, categoryName: "All"));
  //     }
  //     Provider.of<ApplicationProvider>(context, listen: false)
  //         .setCategoryName(categoryList.first.categoryName!);
  //     Provider.of<ApplicationProvider>(context, listen: false)
  //         .setCategoryList(categoryList);
  //     tabController = TabController(length: categoryList.length, vsync: this);
  //     setState(() {});
  //
  //     tabController!.addListener(() {
  //       setState(() {
  //         // selectedIndex = tabController!.index;
  //       });
  //     });
  //   } else {
  //     print("some error occured!!!");
  //   }
  // }

  void onButtonpress(context) {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return Consumer<ApplicationProvider>(builder: (context, provider, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                        child: Icon(Icons.clear_outlined),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 20),
                    child: Text(
                      "Menu categories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: provider.categoryList.length,
                  itemBuilder: (context, index) {
                    // var count = Provider.of<ApplicationProvider>(context, listen: false).selectedRestModel.items!.
                    // where((c) => c.categoryId == categoryList[index].categoryId).toList();

                    return ListTile(
                      title: Text(
                          provider.categoryList[index].categoryName.toString()),
                      // trailing: Text("${count.length}"),
                      // trailing: Text('5'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Dividersection();
                  },
                ),
              ),
              // Consumer<ApplicationProvider>(builder: (context, provider, _) {
              //   return Flexible(
              //     child: ListView.separated(
              //         scrollDirection: Axis.vertical,
              //         separatorBuilder: (context, index) {
              //           return Dividersection();
              //         },
              //         physics: ScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: categoryList.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           Item itemModel =
              //               provider.filteredLoadedProductModelList[index];
              //           return ListTile(
              //             title:
              //                 Text(categoryList[index].categoryName.toString()),
              //             trailing: Text(provider.filteredLoadedProductModelList.length.toString())
              //
              //             // trailing: Text('5'),
              //           );
              //         }),
              //   );
              // })
            ],
          );
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  PersistentHeader(this.tabBar, this.controller);

  final TabBar tabBar;
  TabController controller;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        ),
        child: Row(
          children: [
            InkWell(
                child: Icon(Icons.menu, color: Colors.deepOrange),
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: false,
                    context: context,
                    builder: (context) {
                      return Consumer<ApplicationProvider>(
                          builder: (context, provider, _) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: InkWell(
                                      child: Icon(Icons.clear_outlined),
                                      onTap: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 25, bottom: 20),
                                  child: Text(
                                    "Menu categories",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: provider.categoryList.length,
                                itemBuilder: (context, index) {
                                  List<Item> filteredList = [];
                                  filteredList = provider
                                      .selectedRestModel.items!
                                      .where((product) => (product.categoryId ==
                                          provider
                                              .categoryList[index].categoryId))
                                      .toList();
                                  return ListTile(
                                    onTap: () {
                                      controller.animateTo(index);
                                      VerticalScrollableTabBarStatus.setIndex(
                                          index);
                                      Navigator.of(context).pop();
                                    },
                                    title: Text(provider
                                        .categoryList[index].categoryName
                                        .toString()),
                                    trailing:
                                        Text(filteredList.length.toString()),
                                    // trailing: Text("${count.length}"),
                                    // trailing: Text('5'),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Dividersection();
                                },
                              ),
                            ),
                          ],
                        );
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  );
                }),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: tabBar,
              ),
            ),
          ],
        ));
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
