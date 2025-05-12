clear &&

flutter clean &&
flutter pub get &&

cd macos &&
pod install --repo-update &&
cd .. &&

rm "macos/Runner/GoogleService-Info.plist";
flutterfire configure --project="what-s-that-anime" -m rocks.outdatedguy.whatsthatanime --platforms="macos" -y &&

flutter build macos --release &&

rm -f "installers/dmg_creator/dist/WTA Installer.dmg" &&
mkdir -p "installers/dmg_creator/dist" &&

npx appdmg "installers/dmg_creator/config.json" "installers/dmg_creator/dist/WTA Installer.dmg" &&

open "installers/dmg_creator/dist/";
