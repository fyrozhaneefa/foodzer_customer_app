import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Api/ApiData.dart';
import 'package:foodzer_customer_app/Menu/Microfiles/FiltterSection/constants/divider.dart';
import 'package:foodzer_customer_app/Models/AddressModel.dart';
import 'package:foodzer_customer_app/Models/UserModel.dart';
import 'package:foodzer_customer_app/Models/place.dart';
import 'package:foodzer_customer_app/Preferences/Preferences.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/googleMapScreen.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ChangeAddressFromHome extends StatefulWidget {
  const ChangeAddressFromHome({Key? key}) : super(key: key);

  @override
  State<ChangeAddressFromHome> createState() => _ChangeAddressFromHomeState();
}

class _ChangeAddressFromHomeState extends State<ChangeAddressFromHome> {
  Place selectedLocation = new Place();
  List<AddressModel> getAddressList = [];
  UserData userModel = new UserData();
  TextEditingController searchController = new TextEditingController();
  bool isLoading = false;
  bool isFromCart = false;
  @override
  void initState() {
    UserPreference().getUserData().then((value) {
      userModel = value;
      setState(() {});
      getUserAddress();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 45,
              child: Container(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for your address...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) => applicationBloc.searchPlaces(value),
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minLeadingWidth: 2,
                leading: Icon(
                  Icons.gps_fixed,
                ),
                title: Text(
                  'Current location',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Using GPS',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Container(
                      height: 10,
                    ),
                    Divider(thickness: 3, height: 2)
                  ],
                ),
              ),
             applicationBloc.searchResults != null &&
                  applicationBloc.searchResults?.length != 0?
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: applicationBloc.searchResults?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.location_pin),
                        title: Text(
                          applicationBloc.searchResults![index].description
                              .toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          searchController.text = "";

                          await PlacesService()
                              .getPlace(
                              applicationBloc.searchResults![index].place_id!)
                              .then((value) {
                            selectedLocation = value;
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    GoogleMapScreen(isFromCart,
                                      LatLng( selectedLocation.geometry!.location.lat,
                                        selectedLocation.geometry!.location.lng))));
                            // _getAddressFromLatLng(value.geometry!.location.lat,
                            //     value.geometry!.location.lng);
                            applicationBloc.searchResults!.clear();
                          });
                          setState(() {});
                        },
                      );
                    },
                  ),
                ):
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:20,left: 20.0, bottom:15),
                      child: Text('SAVED ADDRESSES'),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: getAddressList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: (){
                              Provider.of<ApplicationProvider>(context, listen: false)
                                  .setAddressModel(getAddressList[index]);
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      HomeScreen()));
                              UserPreference().setCurrentAddress(getAddressList[index].currentAddressLine.toString());
                              UserPreference().setLatLng(getAddressList[index].addressLat.toString(), getAddressList[index].addressLng.toString());
                            },
                            leading: Icon(
                           getAddressList[index].addressTitle == "HOME"?
                            Icons.home:
                           getAddressList[index].addressTitle == "WORK"?
                            Icons.work:
                            getAddressList[index].addressTitle == "FRIENDS"?
                            Icons.person_pin:
                            Icons.person_pin,
                              color: Colors.deepOrangeAccent,),
                            title: Text(getAddressList[index].addressTitle.toString(),
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(  getAddressList[index].addressBuilding.toString()+" "+
                                getAddressList[index].adressApartmentNo.toString()+" "+
                                getAddressList[index].addressStreetName.toString(),
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis, fontSize: 12),),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ));
  }
  getUserAddress() async {
    isLoading = true;
    setState(() {});
    var map = new Map<String, dynamic>();
    map['user_id'] = userModel.userId;

    var response =
    await http.post(Uri.parse(ApiData.GET_USER_ADDRESS), body: map);
    var json = convert.jsonDecode(response.body);
    List dataList = json['address_list'];
    isLoading = false;
    setState(() {});
    if (response.statusCode == 200) {
      if (null != dataList && dataList.length > 0) {
        getAddressList = dataList
            .map((address) => new AddressModel.fromJson(address))
            .toList();
        setState(() {});
      }
    }
  }
}
