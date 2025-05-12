clear &&

flutter clean &&
flutter pub get &&

flutterfire configure --project="what-s-that-anime" -w "1:665752426509:web:6ebed5b340612a6b0b9d44" --platforms="web" -y &&

flutter build web --release --csp --source-maps --wasm &&

sed -i '' "s/\"app_name\":\"whats_that_anime\"/\"app_name\":\"What\'s That Anime\"/g" "build/web/version.json" &&

rm -rf "installers/web/" &&
mkdir -p "installers/web/" &&

cp -R "build/web/" "installers/web/" &&

open "installers/web/";
