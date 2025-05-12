clear &&

flutter clean &&
flutter pub get &&

flutterfire configure --project="what-s-that-anime" -a rocks.outdatedguy.whatsthatanime --platforms="android" -y &&

flutter build apk --release &&

rm -f "installers/android/apk/What's That Anime.apk" &&
mkdir -p "installers/android/apk/" &&

cp -R "build/app/outputs/flutter-apk/app-release.apk" "installers/android/apk/What's That Anime.apk" &&

open "installers/android/apk/";
