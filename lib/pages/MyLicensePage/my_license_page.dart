// Flutter Packages
import 'package:flutter/material.dart';

// Third Party Packages
import 'package:package_info_plus/package_info_plus.dart';

class MyLicensePage extends StatefulWidget {
  const MyLicensePage({super.key});

  @override
  State<MyLicensePage> createState() => _MyLicensePageState();
}

class _MyLicensePageState extends State<MyLicensePage> {
  PackageInfo? packageInfo;

  Future<void> _getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      key: ValueKey(packageInfo),
      applicationIcon: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                  .withValues(alpha: .69),
              blurRadius: 10,
            ),
          ],
        ),
        width: 150,
        height: 150,
      ),
      applicationName: packageInfo?.appName,
      applicationVersion: packageInfo?.version,
      applicationLegalese: 'Copyright © 2022 OutdatedGuy',
    );
  }
}
