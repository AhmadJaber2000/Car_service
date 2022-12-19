import 'dart:async';

import 'package:Car_service/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  final int id;

  const MapSample({super.key, required this.id});
  @override
  State<MapSample> createState() => MapSampleState();
}

Location location = new Location();
late bool _serviceEnabled;
late PermissionStatus _permissionGranted;
late LocationData _location;
Completer<GoogleMapController> _controller = Completer();

List<Marker> markers = [
  Marker(
    rotation: 0.0,
    markerId: MarkerId('first place'),
    infoWindow: InfoWindow(title: 'this place is so nice'),
    position: LatLng(32.061123, 36.088775),
  ),
  Marker(
    rotation: 0.0,
    markerId: MarkerId('first place'),
    infoWindow: InfoWindow(title: 'this place is so nice'),
    position: LatLng(32.0967382, 36.1089721),
  ),
  Marker(
    rotation: 0.0,
    markerId: MarkerId('first place'),
    infoWindow: InfoWindow(title: 'this place is so nice'),
    position: LatLng(32.0891173, 36.1081806),
  ),
  Marker(
    rotation: 0.0,
    markerId: MarkerId('first place'),
    infoWindow: InfoWindow(title: 'this place is so nice'),
    position: LatLng(32.0954904, 36.1093087),
  ),
  Marker(
    rotation: 0.0,
    markerId: MarkerId('first place'),
    infoWindow: InfoWindow(title: 'this place is so nice'),
    position: LatLng(32.0969443, 36.127042),
  ),
];
final CameraPosition _kLake = CameraPosition(
  target: LatLng(37.773972, -122.431297),
  zoom: 11.5,
);

class MapSampleState extends State<MapSample> {
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //storeUserLocation();

    checkLocationServicesInDevice();
  }

  Future<void> checkLocationServicesInDevice() async {
    Location location = new Location();

    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        _location = await location.getLocation();

        print(_location.latitude.toString() +
            " " +
            _location.longitude.toString());

        location.onLocationChanged.listen((LocationData currentLocation) {
          print(currentLocation.latitude.toString() +
              " " +
              currentLocation.longitude.toString());
        });
      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed before');
        } else {
          _permissionGranted = await location.requestPermission();

          if (_permissionGranted == PermissionStatus.granted) {
            print('user allowed');
          } else {
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
  }

  // storeUserLocation() {
  //   Location location = new Location();
  //
  //   location.onLocationChanged.listen((LocationData currentLocation) {
  //     FirebaseFirestore.instance
  //         .collection(usersCollection)
  //         .doc('EpDGJ9yBqVYMurla0LBoHgEhFUC2')
  //         .set({
  //       'location': GeoPoint(currentLocation.latitude!.toDouble(),
  //           currentLocation.longitude!.toDouble()),
  //       'name': String
  //     });
  //   });
  // }
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
        backgroundColor: primecolor,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(38.9637, 35.2433),
          zoom: 0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.toSet(),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.black,
      //   foregroundColor: Colors.white,
      //   onPressed: () => _googleMapController
      //       .animateCamera(CameraUpdate.newCameraPosition(_kLake)),
      //   label: Text('current location'),
      //   icon: Icon(Icons.location_on),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
