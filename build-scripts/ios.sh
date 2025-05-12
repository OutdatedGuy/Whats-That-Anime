clear &&

flutter clean &&
flutter pub get &&

cd ios &&
pod install --repo-update &&
cd .. &&

rm "ios/Runner/GoogleService-Info.plist";
flutterfire configure --project="what-s-that-anime" -i rocks.outdatedguy.whatsthatanime --platforms="ios" -y &&

flutter build ipa --release &&

rm -f "installers/ios/What's That Anime.ipa" &&
mkdir -p "installers/ios/" &&

cp -R "build/ios/ipa/WhatsThatAnime.ipa" "installers/ios/What's That Anime.ipa" &&

open "installers/ios/";
