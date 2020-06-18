import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import 'app_state.dart';

class ReportService {
  Geoflutterfire geo = Geoflutterfire();

  AuthService _authService = new AuthService();
  Firestore _fireStore = Firestore.instance;

  Future<void> submitReport(
      String brand, String color, File file, String description, String tag, context) async {
    if (file != null) {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('reports/${Path.basename(file.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      await storageReference.getDownloadURL().then((fileURL) {
        print('File Uploaded');
        _authService.currentUser().then((user) {
          var data = {
            'brand': brand,
            'color': color,
            'description': description,
            'photo': fileURL,
            'tag': tag,
            'reporter': user.id.toString(),
            'date': new DateTime.now(),
          };
          _fireStore.collection("cases").document(tag).setData(data).then((results) {
            print("successfully reported a case");
          });
        });
      });
    } else {
      _authService.currentUser().then((user) {
        var data = {
          'brand': brand,
          'color': color,
          'description': description,
          'photo': '',
          'tag': tag,
          'reporter': user.id.toString(),
          'date': new DateTime.now(),
        };
        _fireStore.collection("cases").document(tag).setData(data).then((results) {
          print("successfully reported a case");
        });
      });
    }

    var appState = Provider.of<AppState>(context, listen: false);
    Position pos = appState.getLocationCoordinates();

    _updateAnimalLocation(tag, pos);
  }

  _updateAnimalLocation(String tag, Position pos) async {
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    print('Geo point coordinates');
    String id = await _authService.currentUser().then((user) {
      if (user != null) {
        return user.id;
      }
      return null;
    });
    if (id != null) {
      _fireStore.collection('cases').document(tag).collection('map_coords').add({
        'position': point.data,
        'uid': id,
        'date': new DateTime.now(),
      });
    }
  }

  Stream<QuerySnapshot> getMatimelaCases() {
    return _fireStore.collection("cases").snapshots();
  }

  Stream<QuerySnapshot> getAllCases() {
    return _fireStore.collection("cases").snapshots();
  }

  Future<QuerySnapshot> getMyMatimelaCases() async {
    var user = await _authService.currentUser();
    DocumentSnapshot json = await _fireStore.collection('profile').document(user.id).get();
    Profile profile = Profile.fromJson(json);
    var docs = await _fireStore
        .collection('cases')
        .where('brand', isEqualTo: profile.brandName)
        .getDocuments();
    return docs;
  }
}
