// Flutter Packages
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Third Party Packages
import 'package:desktop_drop/desktop_drop.dart';

// Pages
import 'package:whats_that_anime/pages/AnimeSearchPage/anime_search_page.dart';

// Data Models
import 'package:whats_that_anime/models/my_result.dart';

// Widgets
import 'widgets/image_preview.dart';
import 'widgets/my_search_button.dart';

// Functions
import 'functions/upload_image_to_firebase.dart';
import 'functions/show_result_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image;
  bool _isImageHovered = false;

  void _selectImage() async {
    _image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 40,
        ) ??
        _image;
    setState(() {});
  }

  void _uploadImage() async {
    if (_image == null) return;
    MyResult result = await uploadImageToFirebase(_image!);

    if (!mounted) return;

    if (result.status == ResultStatus.success) {
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => AnimeSearchPage(imageURL: result.url!),
        ),
      );

      _image = null;
      setState(() {});
    } else {
      showResultToast(context: context, result: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          // ! To maximize colum's width, do not remove
          Row(),
          const SizedBox(height: 35),
          DropTarget(
            onDragDone: (data) {
              if (data.files.isEmpty) return;

              for (final file in data.files) {
                if (file.mimeType?.startsWith('image/') ?? false) {
                  setState(() => _image = file);
                  break;
                }
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
              child: ImagePreview(image: _image),
            ),
          ),
          const SizedBox(height: 35),
          MySearchButton(hidden: _image == null, onPressed: _uploadImage),
          const Spacer(),
          ElevatedButton(
            onPressed: _selectImage,
            child: const Text('Select from Gallery'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
