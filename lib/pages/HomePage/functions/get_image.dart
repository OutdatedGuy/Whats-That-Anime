// Flutter Packages
import 'package:image_picker/image_picker.dart';

// Dart Packages
import 'dart:io';

Future<File?> getImage({required ImageSource source}) async {
  final XFile? image = await ImagePicker().pickImage(
    source: source,
    imageQuality: 75,
  );

  return image == null ? null : File(image.path);
}
