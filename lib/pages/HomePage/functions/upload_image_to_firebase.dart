// Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart' show XFile;

// Data Models
import 'package:whats_that_anime/models/my_result.dart';

// Functions
import 'style_loading.dart';

/// Adding image to dailyImage directory for this user
Future<MyResult> uploadImageToFirebase(XFile file) async {
  styleLoading();
  EasyLoading.show(status: 'Loading Image...');

  try {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception();

    final Reference storageRef = FirebaseStorage.instance.ref('users');

    if (await file.length() > 1024 * 1024) {
      // show warning if image is too large
      EasyLoading.dismiss();
      return MyResult(
        status: ResultStatus.warning,
        code: 'Image too Large',
        message: 'Image size exceeds 1MB limit. Please select a smaller image.',
      );
    }

    // Generate image name and get firebase storage reference
    String imgName = DateTime.now().toString().split('.')[0];
    imgName = imgName.replaceAll(RegExp(r' '), 'T');
    final Reference userRef = storageRef.child(
      '${user.uid}/animeImages/$imgName.${file.mimeType?.split('/').last ?? 'jpg'}',
    );

    // Start upload and show progress
    final UploadTask uploadTask = userRef.putData(
      await file.readAsBytes(),
      SettableMetadata(contentType: file.mimeType),
    );
    uploadTask.snapshotEvents.listen((TaskSnapshot event) async {
      if (event.state == TaskState.running) {
        final progress = event.bytesTransferred / event.totalBytes;
        if (progress case < 0.0 || > 1.0) return;

        EasyLoading.showProgress(
          progress,
          status:
              'Uploading Image...\n'
              '${(progress * 100).toStringAsFixed(0)}% Completed',
        );
      }
    });

    await uploadTask.whenComplete(() => null);

    final String downloadUrl = await userRef.getDownloadURL();

    EasyLoading.dismiss();

    return MyResult(
      status: ResultStatus.success,
      code: 'Image Uploaded',
      url: downloadUrl,
    );
  } on Exception {
    EasyLoading.dismiss();
    return MyResult(
      status: ResultStatus.error,
      code: 'Image Upload Failed',
      message:
          'An error occurred while uploading your image. Please try again.',
    );
  }
}
