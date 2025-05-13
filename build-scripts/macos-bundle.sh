clear &&

rm -f "installers/dmg_creator/dist/WTA Installer.dmg" &&
mkdir -p "installers/dmg_creator/dist" &&

npx appdmg "installers/dmg_creator/config.json" "installers/dmg_creator/dist/WTA Installer.dmg" &&

open "installers/dmg_creator/dist/"
