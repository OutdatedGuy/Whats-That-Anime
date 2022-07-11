// Flutter Packages
import 'package:flutter/material.dart';

// Dart Packages
import 'dart:typed_data';

// Third Party Packages
import 'package:dotted_border/dotted_border.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key? key,
    required this.imageData,
  }) : super(key: key);

  final Uint8List? imageData;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).colorScheme.primary,
      borderType: BorderType.RRect,
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      dashPattern: [imageData == null ? 6.9 : 1],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 600),
        color: imageData != null ? Colors.black87 : null,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
            child: imageData == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('No Image Selected'),
                      SizedBox(height: 10),
                      Text('Drop or Paste an image here'),
                      SizedBox(height: 10),
                      Icon(Icons.file_download_outlined),
                    ],
                  )
                : Image.memory(
                    imageData!,
                    errorBuilder: (p0, p1, p2) => const Icon(
                      Icons.broken_image,
                      color: Colors.red,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
