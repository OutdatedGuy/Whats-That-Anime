// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

// Dart Packages
import 'dart:io';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key? key,
    required XFile? image,
  })  : _image = image,
        super(key: key);

  final XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('No Image Selected'),
                    SizedBox(height: 10),
                    Text('Drag and drop an image here'),
                    SizedBox(height: 10),
                    Icon(Icons.file_download_outlined),
                  ],
                )
              : kIsWeb
                  ? Image.network(
                      _image!.path,
                      errorBuilder: (p0, p1, p2) => const Placeholder(),
                    )
                  : Image.file(
                      File(_image!.path),
                      errorBuilder: (p0, p1, p2) => const Placeholder(),
                    ),
        ),
      ),
    );
  }
}
