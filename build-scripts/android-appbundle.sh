clear &&

flutter clean &&
flutter pub get &&

flutterfire configure --project="what-s-that-anime" -a rocks.outdatedguy.whatsthatanime --platforms="android" -y &&

flutter build appbundle --release &&

rm -f "installers/android/appbundle/What's That Anime.aab" &&
mkdir -p "installers/android/appbundle/" &&

cp -R "build/app/outputs/bundle/release/app-release.aab" "installers/android/appbundle/What's That Anime.aab" &&

open "installers/android/appbundle/";
