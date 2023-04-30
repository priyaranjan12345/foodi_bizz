import 'dart:io';

import 'package:file_picker/file_picker.dart';

class SelectFile {
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    }

    return null;
  }
}
