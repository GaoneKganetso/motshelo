import 'dart:convert';
import 'dart:developer' as developer;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const apiKey = "AIzaSyDuyMpqQnoHePUXAdmzQbaJ8ceAUSWyM8M";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    String error = jsonDecode(response.body)['error_message'];
    if (error != null) {
      developer.log(error);
    }
    Map values = jsonDecode(response.body);

    return error != null
        ? jsonDecode(response.body)
        : values["routes"][0]["overview_polyline"]["points"];
  }
}
