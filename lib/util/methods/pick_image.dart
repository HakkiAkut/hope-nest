import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImage {
  Future<File> chooseFile() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }
}
