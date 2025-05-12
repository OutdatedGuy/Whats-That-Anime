// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:flutter_easyloading/flutter_easyloading.dart';

void styleLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.purple
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..progressColor = Colors.white
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.wave;
}
