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
import 'package:package_info_plus/package_info_plus.dart';

class MyLicensePage extends StatefulWidget {
  const MyLicensePage({Key? key}) : super(key: key);

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
            image: AssetImage('assets/icons/launcher_icon_border.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                  .withOpacity(0.69),
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
