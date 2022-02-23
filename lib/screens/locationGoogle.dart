import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:search_map_place/search_map_place.dart';
// import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_geocoder/geocoder.dart' as geoCo;


class LocationScreen extends StatefulWidget {



  @override
  LocationScreenState createState() => LocationScreenState();
}
class LocationScreenState extends State<LocationScreen> {

  // String mobileNo;
  // bool isFromAppBar=false;

  // LocationScreenState(this.mobileNo,this.isFromAppBar);

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Completer<GoogleMapController> mapController = Completer();
  TextEditingController addressController = new TextEditingController();
  TextEditingController searchAddressController = new TextEditingController();
  GoogleMapController? _mapController;
  // RoundedLoadingButtonController loadingController = new RoundedLoadingButtonController();

  LatLng latLongCurrent = LatLng(0, 0);
  LatLng latLong = new LatLng(0, 0);
  Position? _currentPosition;
  String? _currentAddress;
  bool isCameraMoving = false;
  var _controller = TextEditingController();
  // var uuid = new Uuid();
  //
  // String _sessionToken = Uuid().toString();
  List<dynamic>_placeList = [];

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // Map args = ModalRoute.of(context).settings.arguments;


    final googleMap = GoogleMap(

      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: null != latLongCurrent ? latLongCurrent : latLong,
        // so if lat, lng is null, we use 0 as placeholder.
        zoom: 17.0,
      ),
      onCameraMove: (CameraPosition position) {
        isCameraMoving = true;
        latLongCurrent =
        new LatLng(position.target.latitude, position.target.longitude);
      },
      onCameraIdle: () { //update dragged location here
        if (isCameraMoving) {
          _getAddressFromLatLng(
              latLongCurrent.latitude, latLongCurrent.longitude);
          isCameraMoving = false;
        }
      },
      myLocationEnabled: true,
    );
    final currentLocationBtn = SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: Padding(
          padding: EdgeInsets.only(left: 10.0,right: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white
            ),
            // color: Colors.white,
            // // elevation: 5.0,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(30.0),
            //
            // ),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: 0),
                      child: Icon(
                        Icons.location_searching,
                        size: 18,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                  TextSpan(
                      text: "   Use current location",
                      style: TextStyle(
                          color: Colors.lightBlue
                      )
                  ),
                ],
              ),
            ),
            onPressed: (){
              _getAddressFromLatLng(0, 0);
            },
            // ),
          ),
        )

    );
    // final saveLocationBtn = Padding(
    //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
    //   child: RoundedLoadingButton(
    //     width: double.infinity,
    //     controller: loadingController,
    //     child: Text("Save address",
    //         textAlign: TextAlign.center,
    //         style: style.copyWith(
    //             color: Colors.white,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 15)),
    //     color: Colors.lightBlue,
    //     onPressed: () {
    //       LocationModel locationModel = new LocationModel();
    //       locationModel.mapAddress = addressController.text.replaceAll(" ", "");
    //       locationModel.latitude = latLongCurrent.latitude;
    //       locationModel.longitude = latLongCurrent.longitude;
    //       saveLocation(locationModel, loadingController, context);
    //     },
    //   ),
    // );


    final addressField = Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: TextField(
        controller: addressController,
        obscureText: false,
        autocorrect: true,
        maxLines: null,
        autofocus: false,
        enabled: false,
        style: TextStyle(
            fontSize: 15.0
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          hintMaxLines: 1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: "Address",
        ),
      ),
      // )
    );
    final searchAddress = Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 8),
            child: TextField(
              controller: _controller,
              obscureText: false,
              autocorrect: true,
              maxLines: null,
              autofocus: false,
              style: TextStyle(
                  fontSize: 15.0
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                hintMaxLines: 1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Search address",
              ),
            ),
            // )
          ),
        ),
        GestureDetector(
          child: Icon(
            Icons.search,

          ),
          onTap: () {

          },
        )

      ],
    );

    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: SafeArea(
          child:Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // SearchMapPlaceWidget(
                      //   placeType: PlaceType.address,
                      //   placeholder: "Search place",
                      //   apiKey: "AIzaSyC1LbfNrDgPCd7CYz3C4lcQSuSbYnZ5AG8",
                      //   onSelected: (Place place) async {
                      //     Geolocation? geolocation = await place.geolocation;
                      //     _mapController?.animateCamera(
                      //         CameraUpdate.newLatLng(geolocation?.coordinates));
                      //     _mapController?.animateCamera(
                      //         CameraUpdate.newLatLngBounds(
                      //             geolocation?.bounds, 0));
                      //   },
                      // ),
                      SizedBox(height: 10.0,),

                      new Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.60,

                            child: new Container(

                              child: googleMap,
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(100.0),
                                  topRight: const Radius.circular(100.0),
                                ),
                              ),
                            ),

                          ),

                          Positioned.fill( //center of screen
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.location_history,
                                size: 40,
                                color: Colors.lightBlue,),

                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      addressField,
                      SizedBox(height: 10,),
                      currentLocationBtn,
                      SizedBox(height: 10,),
                      searchAddress,
                      // saveLocationBtn,
                      SizedBox(height: 10,),

                      // Expanded(
                      //   child: Align(
                      //     alignment: FractionalOffset.bottomCenter,
                      //     child: saveLocationBtn,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )

      ),


    );
  }

  @override
  void initState() {
    _controller.addListener(() {
      _onChanged();
    });
    _getAddressFromLatLng(0, 0);

    super.initState();
  }

  void _onChanged() {
    // if (_sessionToken == null) {
    //   setState(() {
    //     _sessionToken = uuid.v4();
    //   });
    // }
    getLocationResults(_controller.text);
  }

  void getLocationResults(String input) async {
    String kPLACES_API_KEY = "AIzaSyDkqhaT1weCdUwCPuUT9OqKsGbCQPGsMM8";
    String type = "(regions)";
    String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseURL?input=$input&types=(cities)&key=$kPLACES_API_KEY";
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print("zzz" + response.body);
      setState(() {
        _placeList = json.decode(response.body)["predictions"];
      });
    } else {
      throw Exception("Failed to load places");
    }
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      if (latitude == 0 && longitude == 0) {
        latitude = position.latitude;
        longitude = position.longitude;
      }
      final cords = geoCo.Coordinates(latitude, longitude);
      var address = await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
      // List<Placemark> placemark = await Geolocator.placemarkFromCoordinates(
      //     latitude, longitude);
      //
      // Placemark place = placemark[0];
      if (null ==
          latLongCurrent) { // handle first time open...in first time open move zoom camera to current position...
        latLongCurrent = LatLng(latitude, longitude);

        _mapController?.moveCamera(CameraUpdate.newLatLng(latLongCurrent));
      } else {
        _mapController?.animateCamera(CameraUpdate.newLatLng(latLongCurrent));
      }


      setState(() {
        _currentAddress =address.first.addressLine;
        // "${place.name},${place.locality}, ${place.postalCode}, ${place
        //     .country}";
        addressController.text = _currentAddress!;
        print("zzz" + _currentAddress!);
      });
    } catch (e) {
      print(e);
    }
  }

  // Future saveLocation(LocationModel locationModel,
  //     RoundedLoadingButtonController loadingButtonController,
  //     BuildContext context) async {
  //   String url = Urls.BASE_URL + Urls.ADD_USER_LOCATION_API;
  //
  //   String userJson = LocationModel.toJson(locationModel, mobileNo);
  //   userJson = toJsonArray("resultset", userJson);
  //
  //   final response = await http.post(url, headers: Urls.headers,
  //       body: userJson);
  //
  //   if (response.statusCode == 200) {
  //     loadingController.stop();
  //     String responseString = response.body;
  //
  //     var jsonObject = jsonDecode(responseString)['resultset'] as List;
  //     List<ResponseModel> responseModelList = jsonObject.map((responseModel) =>
  //         ResponseModel.fromJson(responseModel)).toList();
  //     if (null != responseModelList && responseModelList.length > 0) {
  //       if (responseModelList[0].flag == 1) {
  //         Preference().setUserLocation(locationModel);
  //
  //         if(isFromAppBar){
  //           Navigator.of(context).pop();
  //         }else{
  //           Navigator.of(context).push(MaterialPageRoute(
  //               builder: (BuildContext context) => ShopTypeScreen(mobileNo)));
  //         }
  //
  //       } else {
  //         loadingController.reset();
  //
  //         Fluttertoast.showToast(
  //             msg: "Something went wrong, try again",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.blueGrey,
  //             textColor: Colors.white,
  //             fontSize: 14.0);
  //
  //       }
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       loadingController.reset();
  //
  //       throw Exception('Request failed with error');
  //     }
  //   }
  // }
}