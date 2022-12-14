import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:Car_service/authenticate/service/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../model/user.dart';
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
    users = widget.service.contains("location")?
    await FireStoreUtils.getMarchantsLocation(widget.roleType):
    await FireStoreUtils.getMarchantsRate(widget.roleType);
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
      setState(() {
        myMarkers.add(Marker(
          markerId: MarkerId('${user.firstName}'),
          position: LatLng(user.lat, user.long),
          infoWindow: InfoWindow(
            title: user.firstName,
          ),
          // icon: customDescriptor,
        ));
      });
    }
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
