clear &&

flutter clean &&
flutter pub get &&

cd macos &&
pod install --repo-update &&
cd .. &&

rm "macos/Runner/GoogleService-Info.plist";
flutterfire configure --project="what-s-that-anime" -m rocks.outdatedguy.whatsthatanime --platforms="macos" -y &&

rm -rf "installers/dmg_creator/Whats That Anime.app" &&

flutter build macos --release;
