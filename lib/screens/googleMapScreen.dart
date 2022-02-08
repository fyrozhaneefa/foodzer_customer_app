import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/helper.dart';

class GoogleMapScreen extends StatefulWidget {
  static const routeName = "/googleMapScreen";
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
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
            , onPressed: () {  },),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: 45,
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                      hintText: 'Search for your address...',
                      prefixIcon: Icon(Icons.search,
                      color: Colors.black,),
                      ),
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
      body:Stack(
        children: [
          Container(
            child: GoogleMap(
              mapToolbarEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(9.790355,76.853355),
                zoom: 10),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height:60,
                width: double.infinity,
              child:ElevatedButton(
                  onPressed: () {},
                child:Text("Deliver here"),
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
          ),
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
}
