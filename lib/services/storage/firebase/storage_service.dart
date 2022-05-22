import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/services/storage/base/storage_base.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService implements StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  late Reference _reference;

  @override
  Future<String?> uploadFile(
      {required String uid, required File uploadedFile}) async {
    String time = "${DateTime.now().millisecondsSinceEpoch}";
    _reference = _firebaseStorage
        .ref()
        .child(uid)
        .child(time);
    UploadTask uploadTask = _reference.putFile(uploadedFile);
    var url;
    try {
      await uploadTask
          .whenComplete(() async => url = await _reference.getDownloadURL());
    } catch (e) {
      return null;
    }

    return url;
  }
}
