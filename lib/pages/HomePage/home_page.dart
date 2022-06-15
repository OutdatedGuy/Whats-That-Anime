// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

// Dart Packages
import 'dart:io';

// Pages
import 'package:whats_that_anime/pages/AnimeSearchPage/anime_search_page.dart';

// Data Models
import 'package:whats_that_anime/models/my_result.dart';

// Widgets
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
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
              color: _image != null ? Colors.black87 : null,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                child: _image == null
                    ? const Text('No Image Selected')
                    : kIsWeb
                        ? Image.network(
                            _image!.path,
                            errorBuilder: (context, error, stackTrace) {
                              return const Placeholder();
                            },
                          )
                        : Image.file(
                            File(_image!.path),
                            errorBuilder: (context, error, stackTrace) {
                              return const Placeholder();
                            },
                          ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          MySearchButton(image: _image, onPressed: _uploadImage),
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
