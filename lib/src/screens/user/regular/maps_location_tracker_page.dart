import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matimela/src/utils/google_maps_config.dart';
import 'package:random_string/random_string.dart';

const double CAMERA_ZOOM = 10;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class MapsLocationTrackerPage extends StatefulWidget {
  const MapsLocationTrackerPage({Key key, this.tag}) : super(key: key);

  final tag;

  @override
  _MapsLocationTrackerPageState createState() =>
      _MapsLocationTrackerPageState();
}

class _MapsLocationTrackerPageState extends State<MapsLocationTrackerPage> {
  LatLng _center, _source, _destination;
  Firestore _fireStore = Firestore.instance;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  Future<bool> isMapReady;

  @override
  void initState() {
    super.initState();
    setState(() {
      getCowCoordinates(widget.tag);
    });
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      getCowCoordinates(widget.tag);
    });
  }

  void dispose() {
    super.dispose();
  }

  void getCowCoordinates(String tag) async {
    _fireStore
        .collection('cases')
        .document(tag)
        .collection('map_coords')
        .orderBy('date', descending: false)
        .snapshots()
        .listen((snapshot) async {
      for (var i = 0; i < snapshot.documents.length; i++) {
        var doc = snapshot.documents[i];
        GeoPoint pos = doc.data['position']['geopoint'];

        var latLng = LatLng(pos.latitude, pos.longitude);
        _addMarker(latLng, "Last Seen", doc.data['date'].toDate().toString(),
            i == snapshot.documents.length - 1 ? 0 : 1);
        if (i != 0) {
          setState(() {
            _destination = latLng;
            _googleMapsServices
                .getRouteCoordinates(_source, _destination)
                .then((route) {
              setState(() {
                createRoute(route, randomString(100));
              });
            });
            _source = latLng;
          });
        } else {
          setState(() {
            _source = latLng;
            _center = latLng;
          });
        }
      }
    });
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly, String tag) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(tag),
        width: 2,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.blue));
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String title, String msg, int i) {
    _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(title: title, snippet: msg),
        icon: i == 0
            ? BitmapDescriptor.defaultMarker
            : BitmapDescriptor.defaultMarkerWithHue(140)));
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
    //print(lList.toString());
    return lList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracker'),
        backgroundColor: Colors.blue,
        actions: <Widget>[],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _center == null
          ? CupertinoActivityIndicator()
          : GoogleMap(
              onMapCreated: onCreated,
              initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: CAMERA_ZOOM,
                  bearing: CAMERA_BEARING,
                  tilt: CAMERA_TILT),
              mapType: MapType.hybrid,
              myLocationEnabled: false,
              polylines: _polyLines,
              markers: _markers,
              compassEnabled: true,
              mapToolbarEnabled: true,
              zoomGesturesEnabled: true,
              buildingsEnabled: true,
            ),
    );
  }
}
