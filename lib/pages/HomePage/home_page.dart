// Flutter Packages
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Dart Packages
import 'dart:io';

// Widgets
import 'widgets/my_search_button.dart';

// Functions
import 'functions/get_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;

  void _setImage(ImageSource source) async {
    File? image = await getImage(source: source);
    _image = image ?? _image;
    setState(() {});
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
                    : Image.file(
                        _image!,
                        errorBuilder: (context, error, stackTrace) {
                          return const Placeholder();
                        },
                      ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          MySearchButton(image: _image, onPressed: () {}),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              _setImage(ImageSource.gallery);
            },
            child: const Text('Select from Gallery'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              _setImage(ImageSource.camera);
            },
            child: const Text('Select from Camera'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}