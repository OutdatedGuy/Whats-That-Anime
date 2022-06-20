// Flutter Packages
import 'package:image_picker/image_picker.dart';

// Dart Packages
import 'dart:io';

Future<File?> getImage() async {
  final XFile? image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 40,
  );

  return image == null ? null : File(image.path);
}
