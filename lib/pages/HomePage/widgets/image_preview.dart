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

// Dart Packages
import 'dart:typed_data';

// Third Party Packages
import 'package:dotted_border/dotted_border.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key? key,
    required this.imageData,
    this.onError,
  }) : super(key: key);

  final Uint8List? imageData;
  final VoidCallback? onError;

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
                    errorBuilder: (p0, p1, p2) {
                      onError?.call();
                      return const Icon(
                        Icons.broken_image,
                        color: Colors.red,
                        size: 48,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
