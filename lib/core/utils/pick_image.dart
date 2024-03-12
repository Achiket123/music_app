import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xfile = ImagePicker();
    final image =
        await xfile.pickImage(source: ImageSource.gallery, imageQuality: 50);
    return image != null ? File(image.path) : null;
  } catch (e) {
    return null;
  }
}
