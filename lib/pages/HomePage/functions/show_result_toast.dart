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
import 'dart:math';

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
