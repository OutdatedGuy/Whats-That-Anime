// Copyright (C) 2022 OutdatedGuy
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Flutter Packages
import 'package:image_picker/image_picker.dart';

// Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Other Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
        final double progress = event.bytesTransferred / event.totalBytes;
        EasyLoading.showProgress(
          progress,
          status:
              'Uploading Image...\n${(progress * 100).toStringAsFixed(0)}% Completed',
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
