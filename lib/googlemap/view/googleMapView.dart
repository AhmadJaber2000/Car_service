import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:Car_service/authenticate/service/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user.dart';
import '../../tools/constants.dart';
import '../service/location_service.dart';

class GoogleMapView extends StatefulWidget {
  final String roleType;
  final String service;

  GoogleMapView(this.roleType, this.service);

  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Set<Marker> myMarkers = HashSet<Marker>();
  final Completer<GoogleMapController> _controller = Completer();

  late BitmapDescriptor customDescriptor;
  late LocationData myLocation;
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  LatLng currentLocation = _initialCameraPosition.target;
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functions();
  }

  functions() async {
    getCustomMarker();
    await _getMyLocation();
    await setMarkerCurrentLocation();
    users = widget.service.contains("location")
        ? await FireStoreUtils.getMarchantsLocation(widget.roleType)
        : await FireStoreUtils.getMarchantsRate(widget.roleType);
    await setMarkers();
  }

  getCustomMarker() async {
    customDescriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/marker.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: myMarkers,
      onCameraMove: (CameraPosition pos) {
        setState(() {
          currentLocation = pos.target;
        });
      },
    );
  }

  Future<void> _getMyLocation() async {
    LocationData location = await LocationService().getLocation();
    setState(() {
      myLocation = location;
    });
    await _animateCamera(LatLng(myLocation.latitude!, myLocation.longitude!));
  }

  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 16.00,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  listshops() async {
    // if (shops.isEmpty) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   shops = await shopService.listAll(context, 1, "NEARBY");
    //   print(shops.length);
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  //variables:
  bool isLoading = false;

  setMarkers() {
    for (User user in users) {
      String phone = user.phoneNumber;
      print(user.userID);
      print(phone);
      setState(() {
        myMarkers.add(Marker(
          markerId: MarkerId('${user.firstName}'),
          position: LatLng(user.lat, user.long),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          margin: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.white,
                                  Colors.cyan,
                                ],
                              )),
                          // child: Card(
                          //   color: Colors.black,
                          // ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(user.fullName(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Icon(
                                  Icons.add_call,
                                  color: Colors.cyan,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(" Rate : ${user.rate}",
                                    style: TextStyle(
                                        color: Colors.cyan,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))
                                // Image.asset(
                                //   user.email,
                                //   height: 100,
                                // ),
                              ],
                            ),
                            // Card(
                            //   child: CupertinoButton(
                            //     onPressed: () {},
                            //     child: ListTile(
                            //       leading: CircleAvatar(
                            //         child: Text('${user.rate}'),
                            //         radius: 30,
                            //       ),
                            //       title: Text(user.fullName()),
                            //       subtitle: Text(user.email),
                            //     ),
                            //   ),
                            // ),
                          ]),
                        ),
                        const Divider(
                          thickness: 4,
                          height: 10,
                          color: gold,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 6,
                          margin: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.white,
                                  Colors.cyan,
                                ],
                              )),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            launch('tel://${user.phoneNumber}');
                                          },
                                          child: buildChoice(
                                              "Call Now",
                                              const Icon(
                                                Icons.call,
                                                color: Colors.green,
                                              ))),
                                    ),
                                    Expanded(
                                        child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => ListMechanicByRate()));
                                            },
                                            child: buildChoice(
                                                "Chat",
                                                const Icon(
                                                  Icons.chat,
                                                  color: Color(0xff326ada),
                                                )))),
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            RateMyApp _rateMyApp = RateMyApp(
                                              preferencesPrefix:
                                                  'Rate This User',
                                              minDays: 3,
                                              minLaunches: 7,
                                              remindDays: 2,
                                              remindLaunches: 5,
                                            );
                                            _rateMyApp.init().then((_) {
                                              // if (_rateMyApp.shouldOpenDialog) {
                                              _rateMyApp.showStarRateDialog(
                                                context,
                                                title:
                                                    'Enjoying Flutter Rating Prompt?',
                                                message:
                                                    'Please leave a rating!',
                                                actionsBuilder:
                                                    (context, stars) {
                                                  return [
                                                    ElevatedButton(
                                                      child: Text('Ok'),
                                                      onPressed: () async {
                                                        double? star = stars;
                                                        print(star);
                                                        User userd = User();
                                                        Future<User?>
                                                            updateUser() async {
                                                          print("update");
                                                          setState(() {
                                                            user.rate = stars!;
                                                          });
                                                          print(user.rate);
                                                          await FireStoreUtils
                                                              .updateCurrentUser(
                                                                  user);
                                                        }

                                                        setState(() {
                                                          updateUser();
                                                        });

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ];
                                                },
                                                dialogStyle: DialogStyle(
                                                  titleAlign: TextAlign.center,
                                                  messageAlign:
                                                      TextAlign.center,
                                                  messagePadding:
                                                      EdgeInsets.only(
                                                          bottom: 20.0),
                                                ),
                                                starRatingOptions:
                                                    StarRatingOptions(),
                                              );
                                              // }
                                            });
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => RoleTypeGoogleMapPage(
                                            //               userType: user.roletype,
                                            //               service: "location",
                                            //               roleType: user.roletype,
                                            //             )));
                                          },
                                          child: buildChoice(
                                              "Rate",
                                              const Icon(
                                                Icons.star_rate,
                                                color: Colors.amber,
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // child: Card(
                          //   color: Colors.black,
                          // ),
                        ),
                      ],
                    ),
                  );
                });
          },
          infoWindow: InfoWindow(
            title: user.firstName,
          ),
          // icon: customDescriptor,
        ));
      });
    }
  }

  Container buildChoice(String title, Icon icons) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black38)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          icons
        ],
      ),
    );
  }

  setMarkerCurrentLocation() {
    int count = 1;
    setState(() {
      myMarkers.add(Marker(
        markerId: MarkerId("${++count}"),
        position: LatLng(myLocation.latitude!, myLocation.longitude!),
        infoWindow: const InfoWindow(
          title: "my location",
        ),
        // icon: customDescriptor,
      ));
    });
  }
}
