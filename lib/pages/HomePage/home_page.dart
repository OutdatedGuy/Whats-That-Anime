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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

// Dart Packages
import 'dart:typed_data';

// Third Party Packages
import 'package:desktop_drop/desktop_drop.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pasteboard/pasteboard.dart';

// Pages
import 'package:whats_that_anime/pages/AnimeSearchPage/anime_search_page.dart';

// Data Models
import 'package:whats_that_anime/models/my_result.dart';

// Widgets
import 'widgets/image_preview.dart';
import 'widgets/my_search_button.dart';
import 'widgets/paste_listener.dart';

// Functions
import 'functions/upload_image_to_firebase.dart';
import 'functions/show_result_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? _imageData;
  String? _mimeType;
  bool _isImageHovered = false;

  void _selectImage() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 69,
    );
    if (image == null) return;

    _imageData = await image.readAsBytes();
    _mimeType = image.mimeType;
    setState(() {});
  }

  void _uploadImage() async {
    if (_imageData == null) return;
    MyResult result = await uploadImageToFirebase(
      XFile.fromData(_imageData!, mimeType: _mimeType ?? 'image/jpeg'),
    );

    if (!mounted) return;

    if (result.status == ResultStatus.success) {
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => AnimeSearchPage(imageURL: result.url!),
        ),
      );

      _imageData = null;
      _mimeType = null;
      setState(() {});
    } else {
      showResultToast(context: context, result: result);
    }
  }

  void _getImageFromClipboard() async {
    _imageData = await Pasteboard.image ?? _imageData;
    _mimeType = null;
    setState(() {});
  }

  void _brokenImage() {
    if (_imageData == null) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _imageData = null;
      _mimeType = null;
      setState(() {});
      MotionToast.error(
        description: const Text(
          'Unable to process image',
          style: TextStyle(color: Colors.black),
        ),
      ).show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PasteListener(
      onPaste: _getImageFromClipboard,
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Column(
          children: <Widget>[
            // ! To maximize colum's width, do not remove
            Row(),
            const SizedBox(height: 35),
            DropTarget(
              onDragDone: (data) async {
                for (final file in data.files) {
                  if (file.mimeType?.startsWith('image/') != true) continue;

                  _imageData = await file.readAsBytes();
                  _mimeType = file.mimeType;
                  setState(() {});
                  break;
                }
              },
              onDragEntered: (_) => setState(() => _isImageHovered = true),
              onDragExited: (_) => setState(() => _isImageHovered = false),
              child: Container(
                foregroundDecoration: BoxDecoration(
                  color: _isImageHovered
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.420)
                      : null,
                ),
                child: ImagePreview(
                  imageData: _imageData,
                  onError: _brokenImage,
                ),
              ),
            ),
            const SizedBox(height: 35),
            MySearchButton(hidden: _imageData == null, onPressed: _uploadImage),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Select from Gallery'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
