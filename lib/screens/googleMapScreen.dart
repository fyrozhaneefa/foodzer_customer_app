

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/Services/myGlobalsService.dart';
import 'package:foodzer_customer_app/Services/places_service.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_geocoder/geocoder.dart' as geoCo;
// import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/place.dart';
import '../Services/geolocator_service.dart';
import '../utils/helper.dart';

class GoogleMapScreen extends StatefulWidget {
  static const routeName = "/googleMapScreen";
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController searchController = new TextEditingController();
  Completer<GoogleMapController> mapController = Completer();
  StreamSubscription? locationSubscription;
  GoogleMapController? _mapController;
  bool isCameraMoving = false;
  bool isPinMoving = false;
  String? _currentAddress;
  LatLng latLongCurrent = LatLng(0, 0);
  LatLng latLong = new LatLng(0, 0);
  Place selectedLocation = new Place();

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    mapController.complete(controller);
  }
@override
  void initState() {
  final applicationBloc = Provider.of<ApplicationBloc>(context ,listen: false);

  // locationSubscription = applicationBloc.selectedLocation.stream.listen((place) {
  //   if(place !=null) {
  //     _goToPlace(place);
  //   }
  // });
    super.initState();
    _getAddressFromLatLng(0, 0);
  }
@override
  void dispose() {

locationSubscription?.cancel();



    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

  final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              size: 26,
              color: Colors.black,)
            , onPressed: () {  },),
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
                      prefixIcon: Icon(Icons.search,
                      color: Colors.black,),
                      ),
                  onChanged: (value) => applicationBloc.searchPlaces(value),
                ),
              ),
              decoration:  BoxDecoration(
                shape: BoxShape.rectangle,
                border:  Border.all(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      body:
      Stack(
        children: [
          Container(
            height:MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              myLocationEnabled: true,
             compassEnabled: true,
             mapToolbarEnabled: true,
             onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target:null != latLongCurrent ? latLongCurrent : latLong,
                zoom: 16),
              onCameraMove: (CameraPosition position) {
                isCameraMoving = true;
                isPinMoving = false;
                setState(() {

                });
                latLongCurrent =
                new LatLng(position.target.latitude, position.target.longitude);
              },
              onCameraIdle: () { //update dragged location here
                if (isCameraMoving) {
                  _getAddressFromLatLng(
                      latLongCurrent.latitude, latLongCurrent.longitude);
                  isCameraMoving = false;
                  isPinMoving = true;
                  setState(() {

                  });
                }
              },
              // markers: Set<Marker>.of(
              //   <Marker>[
              //     Marker(
              //         onTap: () {
              //           print('Tapped');
              //           print(applicationBloc.currentLocation!.latitude);
              //         },
              //         draggable: true,
              //         markerId: MarkerId('Marker'),
              //         position: LatLng(applicationBloc.currentLocation!.latitude, applicationBloc.currentLocation!.longitude),
              //
              //     )
              //   ],
              // ),

            ),
          ),
          Positioned.fill( //center of screen
            child: Align(
              alignment: Alignment.center,
              child: Icon(Icons.location_pin,
                size: 45,
                color: Colors.deepOrangeAccent,),

            ),
          ),
        if(applicationBloc.searchResults !=null && applicationBloc.searchResults?.length != 0)
          Container(
            height:MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              backgroundBlendMode: BlendMode.darken
            ),
          ),
          if(applicationBloc.searchResults !=null && applicationBloc.searchResults?.length != 0)
          Container(
            height:MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: applicationBloc.searchResults?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    applicationBloc.searchResults![index].description.toString(),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    searchController.text = "";

                    await PlacesService().getPlace( applicationBloc.searchResults![index].place_id!).then((value) {
                      selectedLocation=value;
                      _getAddressFromLatLng(value.geometry!.location.lat,
                          value.geometry!.location.lng);
                      applicationBloc.searchResults!.clear();

                    });
                    setState(() {

                    });

                  },
                );
              },
            ),
          ),
          isPinMoving && searchController.text.length == 0?
       Align(
         alignment: Alignment.bottomCenter,
         child: Container(
           color: Colors.white,
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height *.28,
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'Delivery Location',
                   style: TextStyle(
                     color: Colors.grey,
                     fontSize: 16.0,
                     fontWeight: FontWeight.w500
                   ),
                 ),
                 SizedBox(height: 20),
                 TextField(
                   controller: addressController,
                   obscureText: false,
                   autocorrect: true,
                   maxLines: null,
                   autofocus: false,
                   enabled: false,
                   style: TextStyle(
                       fontSize: 18.0
                   ),
                   decoration: new InputDecoration(
                       isDense: true,
                       border: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       enabledBorder: InputBorder.none,
                       errorBorder: InputBorder.none,
                       disabledBorder: InputBorder.none,
                   ),
                 ),
                  SizedBox(
                    height: 10,
                  ),
                 Text(
                   'The selected pin location is a bit far from your current location. Are you sure this is correct?',
                   style: TextStyle(
                     height:1.5
                   ),
                 ),
                 SizedBox(
                   height:25,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     GestureDetector(
                       onTap: (){
                         print('clicked reset');
                         _getAddressFromLatLng(0, 0);
                         isPinMoving = false;
                         setState(() {

                         });
                       },
                       child: Text(
                         'Reset to my location',
                         style: TextStyle(
                           color: Colors.deepOrangeAccent,
                           fontWeight: FontWeight.w600
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(
                             builder: (BuildContext context) =>
                                 HomeScreen()));
                       },
                       child: Text(
                         'Yes, deliver here',
                         style: TextStyle(
                             color: Colors.deepOrangeAccent,
                             fontWeight: FontWeight.w600
                         ),
                       ),
                     )
                   ],
                 )

               ],
             ),
           ),
         ),
       ):Container(),
         !isPinMoving? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height:60,
                width: double.infinity,
              child:ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomeScreen()));
                  },
                child:Text(
                  'Delivery here'
                ),
                style: ElevatedButton.styleFrom(
                    primary:Colors.deepOrange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      // side: BorderSide(color: Colors.grey)
                    )
                ),
              ),
              ),
            ),
          ):Container(),





          // Positioned(
          //   bottom: 100,
          //     right: 20,
          //     child: Container(
          //       child: Text(
          //     "Icon"
          //     ),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //        shape: BoxShape.circle
          //       ),
          //   ),
          // ),
        ],
      ),
    );
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

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
      latLongCurrent = LatLng(latitude, longitude);
      if (null ==
          latLongCurrent) { // handle first time open...in first time open move zoom camera to current position...
        latLongCurrent = LatLng(latitude, longitude);

        _mapController?.animateCamera(CameraUpdate.newLatLng(latLongCurrent));
      } else {

        _mapController?.moveCamera(CameraUpdate.newLatLng(latLongCurrent));
      }


      setState(() {
        _currentAddress =address[0].addressLine;
        // "${place.name},${place.locality}, ${place.postalCode}, ${place
        //     .country}";
        addressController.text = _currentAddress!;
        print("zzz" + _currentAddress!);
        finalAddress = _currentAddress!;
      });
    } catch (e) {
      print(e);
    }
  }
  // Future<void> _goToPlace(Place place) async{
  //   final GoogleMapController controller = await mapController.future;
  //   controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target:LatLng(place.geometry.location.lat,place.geometry.location.lng),
  //         zoom: 14.0
  //       ),
  //     )
  //   );
  // }
}
