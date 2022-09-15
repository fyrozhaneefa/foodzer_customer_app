import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodzer_customer_app/Models/OrderModel.dart';
import 'package:foodzer_customer_app/Models/orderlistmodel.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
import 'package:foodzer_customer_app/screens/home/homeScreen.dart';
import 'package:foodzer_customer_app/utils/designConfig.dart';
import 'package:foodzer_customer_app/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:timelines/timelines.dart';
const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class OrderTracking extends StatefulWidget {
  // final String orderId;
  bool isPaymentDone;
  OrderModel orderModel=new OrderModel();
  OrderTracking(this.orderModel, this.isPaymentDone);
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  final loc.Location location = loc.Location();
  GoogleMapController? _controller;
  bool _added = false;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleApiKey = "AIzaSyCzJV498CgnaMfwp1CdVkl6INwAy_ekPQI";
  int _processIndex = 0;
  BitmapDescriptor? driverIcon, restaurantsIcon, destinationIcon;
  StreamSubscription<DocumentSnapshot>? _eventsSubscription;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  void dispose() {
    _eventsSubscription!.cancel();

    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
   if(widget.isPaymentDone){
     _processIndex = 1;
     setState(() {

     });
     _getPolyline();
     getBoyLocation();
   } else{
     _processIndex = 0;
     setState(() {

     });
   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.clear,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          title: Text(
              'ORDER ${Provider.of<ApplicationProvider>(context, listen: false).currentOrderId.toString()}'),
          titleTextStyle: TextStyle(color: Colors.deepOrange, fontSize: 16),
          actions: [Center(
            child: InkWell(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  'View details',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
            ),
          )],
        ),
        body:
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance.collection('location').snapshots(),
            //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (_added) {
            //       mymap(snapshot);
            //     }
            //     if (!snapshot.hasData) {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //     return
            null == polylineCoordinates || polylineCoordinates.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Helper.getScreenHeight(context) / 2.3,
                        child: GoogleMap(
                          mapType: MapType.terrain,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          markers: Set<Marker>.of(markers.values),
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                polylineCoordinates[0].latitude,
                                polylineCoordinates[0].longitude,
                              ),
                              zoom: 14.75),
                          onMapCreated: _onMapCreated,
                          polylines: Set<Polyline>.of(polylines.values),
                        ),
                      ),
                      Expanded(
                        child: Timeline.tileBuilder(
                          theme: TimelineThemeData(
                            direction: Axis.vertical,
                            nodePosition: 0,
                            connectorTheme: ConnectorThemeData(
                              space: 40.0,
                              thickness: 5.0,
                             indent: 2
                            ),
                          ),
                          builder: TimelineTileBuilder.connected(
                            connectionDirection: ConnectionDirection.before,
                            itemExtentBuilder: (_, __) =>
                            MediaQuery.of(context).size.width / _processes.length,
                            // oppositeContentsBuilder: (context, index) {
                            //   return Padding(
                            //     padding: const EdgeInsets.only(bottom: 15.0),
                            //     // child: Image.asset(
                            //     //   'assets/images/process_timeline/status${index + 1}.png',
                            //     //   width: 50.0,
                            //     //   color: getColor(index),
                            //     // ),
                            //   );
                            // },
                            contentsBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  _processes[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: getColor(index),
                                  ),
                                ),
                              );
                            },
                            indicatorBuilder: (_, index) {
                              var color;
                              var child;
                              if (index == _processIndex) {
                                color = inProgressColor;
                                child = Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                );
                              } else if (index < _processIndex) {
                                color = completeColor;
                                child = Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15.0,
                                );
                              } else {
                                color = todoColor;
                              }

                              if (index <= _processIndex) {
                                return Stack(
                                  children: [
                                    CustomPaint(
                                      size: Size(30.0, 30.0),
                                      // painter: _BezierPainter(
                                      //   color: color,
                                      //   drawStart: index > 0,
                                      //   drawEnd: index < _processIndex,
                                      // ),
                                    ),
                                    DotIndicator(
                                      size: 30.0,
                                      color: color,
                                      child: child,
                                    ),
                                  ],
                                );
                              } else {
                                return Stack(
                                  children: [
                                    CustomPaint(
                                      size: Size(15.0, 15.0),
                                      // painter: _BezierPainter(
                                      //   color: color,
                                      //   drawEnd: index < _processes.length - 1,
                                      // ),
                                    ),
                                    OutlinedDotIndicator(
                                      borderWidth: 4.0,
                                      color: color,
                                    ),
                                  ],
                                );
                              }
                            },
                            connectorBuilder: (_, index, type) {
                              if (index > 0) {
                                if (index == _processIndex) {
                                  final prevColor = getColor(index - 1);
                                  final color = getColor(index);
                                  List<Color> gradientColors;
                                  if (type == ConnectorType.start) {
                                    gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                                  } else {
                                    gradientColors = [
                                      prevColor,
                                      Color.lerp(prevColor, color, 0.5)!
                                    ];
                                  }
                                  return DecoratedLineConnector(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SolidLineConnector(
                                    color: getColor(index),
                                  );
                                }
                              } else {
                                return null;
                              }
                            },
                            itemCount: _processes.length,
                          ),
                        ),
                      )
                    ],
                  ),
        //   },
        // )
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home_outlined),
        onPressed: () {
      setState(() {
        // _processIndex = (_processIndex + 1) % _processes.length;
     Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            HomeScreen()), (Route<dynamic> route) => false);
      });
    },
    backgroundColor: Colors.deepOrangeAccent,
    ),
        );
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller = controller;
      _added = true;
    });
  }
  updateMarker(LatLng latLng, String id) async {
    BitmapDescriptor? icon, defaultIcon;
    MarkerId markerId = const MarkerId("origin");
    driverIcon = await bitmapDescriptorFromSvgAsset(context, "assets/delivery_boy.svg");
    defaultIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    icon = driverIcon;
    Marker _marker = Marker(
      markerId: markerId,
      position: latLng,
      icon: icon ?? defaultIcon,
    );
    if (mounted) {
      setState(() {
        markers[markerId] = _marker;
      });
    }
  }
  _addMarker(LatLng position, String id, int status) async {
    MarkerId markerId = MarkerId(id);
    BitmapDescriptor? icon, defaultIcon;
    if (status == 0) {
      //print("Status:"+status.toString());
      driverIcon = await bitmapDescriptorFromSvgAsset(context, DesignConfig.setSvgPath('delivery_boy'));
      defaultIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      icon = driverIcon;
    } else if (status == 1) {
      //print("Status:"+status.toString());
      restaurantsIcon = await bitmapDescriptorFromSvgAsset(context, DesignConfig.setSvgPath('map_pin'));
      defaultIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      icon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    } else {
      //print("Status:"+status.toString());
      destinationIcon = await bitmapDescriptorFromSvgAsset(context, DesignConfig.setSvgPath('address_icon'));
      defaultIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      icon = destinationIcon;
    }
    setState(() {});
    Marker marker = Marker(markerId: markerId, icon: icon == null ? defaultIcon : icon, position: position);
    markers[markerId] = marker;
  }
  Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, 'marker');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    //double width = 50 * devicePixelRatio;
    //double height = 50 * devicePixelRatio;
    double width = 32 * devicePixelRatio;
    double height = 32 * devicePixelRatio;

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }
  // _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
  //   MarkerId markerId = MarkerId(id);
  //   Marker marker =
  //       Marker(
  //           markerId: markerId,
  //           icon: descriptor,
  //           position: position,
  //           // flat: true,
  //
  //           anchor:id=="BOY"? Offset(0.5,0.5):Offset(0.5,1.0),
  //       );
  //   markers[markerId] = marker;
  //   setState(() {});
  // }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 3,
        polylineId: id,
        color: Colors.deepOrange,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(widget.orderModel.merchantLat!,widget.orderModel.merchantLng!),
        PointLatLng(widget.orderModel.userLat!,widget.orderModel.userLng!),
        travelMode: TravelMode.driving,
        wayPoints: [
          PolylineWayPoint(
              location: widget.orderModel.orderAddress!)
        ]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addMarker(
        LatLng(
            polylineCoordinates[0].latitude, polylineCoordinates[0].longitude),
        "rest",1);


    /// destination marker
    _addMarker(
        LatLng(polylineCoordinates[polylineCoordinates.length - 1].latitude,
            polylineCoordinates[polylineCoordinates.length - 1].longitude),
        "destination",3);
    setState(() {});
    _addPolyLine();
  }
  // Future<Uint8List> getDeliveryBoyMarker() async {
  //   ByteData byteData = await DefaultAssetBundle.of(context).load("assets/bike.png");
  //   return byteData.buffer.asUint8List();
  // }
  // void _onEventsSnapshot(QuerySnapshot snapshot) {
  //   eventsReference.doc(id)
  //       .snapshots()
  //       .listen((event) async {
  //     // Uint8List imageData = await getDeliveryBoyMarker();
  //     // setState(() {});
  //     var data = event.data();
  //
  //     if(null!=_controller) {
  //       await _controller!
  //           .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //           target: LatLng(data!["latitude"], data["longitude"],
  //           ),
  //           zoom: 12.47)));
  //     }
  //     _addMarker(LatLng(data!["latitude"], data["longitude"]), "origin", 0);
  //     updateMarker(LatLng(data["latitude"], data["longitude"]), "origin");
  //
  //   });
  // }
  getBoyLocation()  {
    // isLoading = true;
    // setState(() {});
    //
    List<DocumentSnapshot> docs;
    String id=widget.orderModel.orderId!.substring(6,widget.orderModel.orderId!.length);

    DocumentReference eventsReference =  FirebaseFirestore.instance.collection('location').doc(id);
    _eventsSubscription = eventsReference.snapshots().listen((event) async {
        // eventsReference.doc(id)
        // .snapshots()
        // .listen((event) async {
      // Uint8List imageData = await getDeliveryBoyMarker();
      // setState(() {});
      var data = event.data();
      String orderStatus;
      orderStatus = event.get("orderStatus");
     setState(() {

     });
     if(orderStatus == "1"){
       _processIndex =3;
       setState(() {

       });
     } else if(orderStatus == "2"){
       _processIndex =4;
       setState(() {

       });
     } else{
       _processIndex = 5;
       setState(() {

       });
     }
      if(null!=_controller) {
        await _controller!
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(event.get("latitude"),event.get("longitude"),
            ),
            zoom: 12.47)));
      }
      _addMarker(LatLng(event.get("latitude"),event.get("longitude")), "origin", 0);
      updateMarker(LatLng(event.get("latitude"), event.get("longitude")), "origin");

    });

  }

}

const _processes = [
  'Payment Successful',
  'Waiting for Confirmation',
  'In Kitchen',
  'Dispatched',
  'Delivered',
];