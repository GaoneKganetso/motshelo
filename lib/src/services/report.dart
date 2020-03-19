import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:path/path.dart' as Path;

class ReportService {
  Firestore _fireStore = Firestore.instance;
  AuthService _authService = new AuthService();

  Future<void> submitReport(String brand, String color, File file, String location,
      String description, String tag) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('reports/${Path.basename(file.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;

    await storageReference.getDownloadURL().then((fileURL) {
      print('File Uploaded');
      _authService.currentUser().then((user) {
        print(fileURL);
        var data = {
          'brand': brand,
          'color': color,
          'location': location,
          'description': description,
          'photo': fileURL,
          'tag': tag,
          'reporter': user.id.toString()
        };
        _fireStore.collection("cases").add(data).then((results) {
          print("successfully reported a case");
        });
      });
    });
  }

  Stream<QuerySnapshot> getMatimelaCases() {
    return _fireStore.collection("cases").snapshots();
  }

  Stream<QuerySnapshot> getAllCases() {
    return _fireStore.collection("cases").snapshots();
  }
}
