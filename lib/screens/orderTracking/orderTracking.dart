import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzer_customer_app/blocs/application_bloc.dart';
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
  // final String user_id;
  // OrderTracking(this.user_id);
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleApiKey = "AIzaSyDkqhaT1weCdUwCPuUT9OqKsGbCQPGsMM8";
  int _processIndex = 1;

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
  void initState() {
    super.initState();
    _getPolyline();
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
    //     floatingActionButton: FloatingActionButton(
    //     // child: Icon(FontAwesomeIcons.chevronRight),
    //     onPressed: () {
    //   setState(() {
    //     _processIndex = (_processIndex + 1) % _processes.length;
    //   });
    // },
    // backgroundColor: inProgressColor,
    // ),
        );
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller = controller;
      _added = true;
    });
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
    setState(() {});
  }

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
        PointLatLng(
          double.parse(Provider.of<ApplicationProvider>(context, listen: false)
              .selectedRestModel
              .branchDetails!
              .lat!),
          double.parse(Provider.of<ApplicationProvider>(context, listen: false)
              .selectedRestModel
              .branchDetails!
              .lng!),
        ),
        PointLatLng(
            double.parse(
                Provider.of<ApplicationProvider>(context, listen: false)
                    .selectedAddressModel
                    .addressLat!),
            double.parse(
                Provider.of<ApplicationProvider>(context, listen: false)
                    .selectedAddressModel
                    .addressLng!)),
        travelMode: TravelMode.driving,
        wayPoints: [
          PolylineWayPoint(
              location: Provider.of<ApplicationProvider>(context, listen: false)
                  .selectedAddressModel
                  .currentAddressLine
                  .toString())
        ]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addMarker(
        LatLng(
            polylineCoordinates[0].latitude, polylineCoordinates[0].longitude),
        "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(
        LatLng(polylineCoordinates[polylineCoordinates.length - 1].latitude,
            polylineCoordinates[polylineCoordinates.length - 1].longitude),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    setState(() {});
    _addPolyLine();
  }

  // Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
  //   await _controller
  //       .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(
  //         snapshot.data!.docs.singleWhere(
  //                 (element) => element.id == widget.user_id)['latitude'],
  //         snapshot.data!.docs.singleWhere(
  //                 (element) => element.id == widget.user_id)['longitude'],
  //       ),
  //       zoom: 14.47)));
  // }
}
// class _BezierPainter extends CustomPainter {
//   const _BezierPainter({
//     required this.color,
//     this.drawStart = true,
//     this.drawEnd = true,
//   });
//
//   final Color color;
//   final bool drawStart;
//   final bool drawEnd;
//
//   Offset _offset(double radius, double angle) {
//     return Offset(
//       radius * cos(angle) + radius,
//       radius * sin(angle) + radius,
//     );
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = color;
//
//     final radius = size.width / 2;
//
//     var angle;
//     var offset1;
//     var offset2;
//
//     var path;
//
//     if (drawStart) {
//       angle = 3 * pi / 4;
//       offset1 = _offset(radius, angle);
//       offset2 = _offset(radius, -angle);
//       path = Path()
//         ..moveTo(offset1.dx, offset1.dy)
//         ..quadraticBezierTo(0.0, size.height / 2, -radius,
//             radius) // TODO connector start & gradient
//         ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
//         ..close();
//
//       canvas.drawPath(path, paint);
//     }
//     if (drawEnd) {
//       angle = -pi / 4;
//       offset1 = _offset(radius, angle);
//       offset2 = _offset(radius, -angle);
//
//       path = Path()
//         ..moveTo(offset1.dx, offset1.dy)
//         ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
//             radius) // TODO connector end & gradient
//         ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
//         ..close();
//
//       canvas.drawPath(path, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(_BezierPainter oldDelegate) {
//     return oldDelegate.color != color ||
//         oldDelegate.drawStart != drawStart ||
//         oldDelegate.drawEnd != drawEnd;
//   }
// }
const _processes = [
  'Payment Successful',
  'Waiting for Confirmation',
  'in Kitchen',
  'Ready for pickup',
  'Delivered',
];