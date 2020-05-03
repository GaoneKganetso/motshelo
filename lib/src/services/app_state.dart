import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:matimela/src/utils/google_maps_config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rxdart/rxdart.dart';

const kGoogleApiKey = "AIzaSyAQvZhDnP4hpEsi6EcGBYmp-Pq5lyJv9dE";

class AppState with ChangeNotifier {
  AppState() {
    getUserLocation();
  }

  BuildContext context;
  String currentLocation = '';
  TextEditingController destinationController = TextEditingController();
  AuthService firebaseAuthService = AuthService();
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  TextEditingController locationController = TextEditingController();
  ProgressDialog pr;
  Stream<dynamic> query;
  final radius = BehaviorSubject<double>.seeded(100.0);
  StreamSubscription subscription;
  static LatLng _initialPosition;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  LatLng _lastPosition = _initialPosition;
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  Position myLocation;

  LatLng get initialPosition => _initialPosition;

  LatLng get lastPosition => _lastPosition;

  GoogleMapsServices get googleMapsServices => _googleMapsServices;

  GoogleMapController get mapController => _mapController;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;

// ! TO GET THE USERS LOCATION
  Future<String> getUserLocation() async {
    String error;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      myLocation = (await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best));
      try {
        await Geolocator()
            .placemarkFromCoordinates(myLocation.latitude, myLocation.longitude)
            .then((placemark) {
          _initialPosition = LatLng(myLocation.latitude, myLocation.longitude);
          print("initial position is : ${_initialPosition.toString()}");
          print('Place mark ' + placemark[0].name);
          currentLocation = placemark[0].name;
          if (currentLocation == 'Unnamed Road')
            currentLocation = '';
          //_addGeoPoint(myLocation);
        });

        notifyListeners();
      } catch (e) {
        print(e.message.toString());
      }
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from app settings';
        myLocation = null;
      }
    }
    print("error is ${error}");
    return currentLocation;
  }

  getLocationCoordinates(){
    return myLocation;
  }


  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.clear();
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 10,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address, String msg) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: msg),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  // ! SEND REQUEST
  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    currentLocation = placemark[0].name;
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation, "Destination Location");
    String route = await _googleMapsServices.getRouteCoordinates(
        _initialPosition, destination);
    createRoute(route);
    notifyListeners();
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  void updateQuery(value) {
    radius.add(value);
    notifyListeners();
  }

  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
