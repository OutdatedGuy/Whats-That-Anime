// Dart Packages
import 'dart:math';

// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:motion_toast/motion_toast.dart';

// Data Models
import 'package:whats_that_anime/models/my_result.dart';

void showResultToast({
  required BuildContext context,
  required MyResult result,
}) {
  Text title = Text(
    result.code,
    style: const TextStyle(color: Colors.black),
  );
  Text description = Text(
    result.message ?? 'Success',
    style: const TextStyle(color: Colors.black),
  );

  final width = MediaQuery.of(context).size.width;
  final minWidth = min(width - 20, 320.00);
  final maxWidth = max(minWidth, width * 0.8);
  toastType(result.status)
      .call(
        title: title,
        description: description,
        width: null,
        height: null,
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          maxHeight: 90,
        ),
      )
      .show(context);
}

Function toastType(ResultStatus status) {
  switch (status) {
    case ResultStatus.success:
      return MotionToast.success;
    case ResultStatus.warning:
      return MotionToast.warning;
    case ResultStatus.error:
      return MotionToast.error;
  }
}
