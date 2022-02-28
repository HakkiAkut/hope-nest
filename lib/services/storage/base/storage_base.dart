import 'dart:io';

abstract class StorageMethods {
  Future<String?>? uploadFile({required String uid, required File uploadedFile});
}
