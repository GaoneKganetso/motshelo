import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:path/path.dart' as Path;

class LivestockManager {
  Firestore _fireStore = Firestore.instance;
  AuthService _authService = new AuthService();

  Future<void> registerLivestock(
      String brand, String color, File file, String tag) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('livestock/${Path.basename(file.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;

    await storageReference.getDownloadURL().then((fileURL) {
      print('File Uploaded');
      _authService.currentUser().then((user) {
        print(fileURL);
        var data = {
          'brand': brand,
          'color': color,
          'tag': tag,
          'photo': fileURL,
          'owner': user.id.toString()
        };
        _fireStore.collection("livestock").add(data).then((results) {
          print("successfully registered livestock");
        });
      });
    });
  }

  Future countMyLivestock() async {
    var user = await _authService.currentUser();
    var docs = await _fireStore
        .collection('livestock')
        .where('owner', isEqualTo: user.id.toString())
        .getDocuments();
    return docs.documents.length;
  }

  Stream<QuerySnapshot> getMyLivestock(String id) {
    return _fireStore.collection('livestock').where('owner', isEqualTo: id.toString()).snapshots();
  }
}
