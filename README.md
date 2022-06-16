<p align="center">
  <img src="https://user-images.githubusercontent.com/74326345/174189371-f1da1984-3ff3-4052-b996-9daf05cebe6b.png" width="250px" height="250px"></img>
</p>

<h1 align="center">What's That Anime</h1>

## Light Mode

<p align="center">
  <img src="https://user-images.githubusercontent.com/74326345/174185127-b7253d51-e1c3-4009-829a-bb6a660e96bf.jpg" width="22%" height="440px"></img>
  <img src="https://user-images.githubusercontent.com/74326345/174185178-35409090-3dca-4e0b-a8d6-cef221586893.jpg" width="22%" height="440px"></img>
  <img src="https://user-images.githubusercontent.com/74326345/174185212-ee7a5d82-f1c6-4449-9c42-59364f402400.jpg" width="22%" height="440px"></img>
  <img src="https://user-images.githubusercontent.com/74326345/174185263-c81a8514-55c4-42f7-b7f1-c0b565f65d6d.jpg" width="22%" height="440px"></img>
</p>

## Dark Mode

<p align="center">
  <img src="https://user-images.githubusercontent.com/74326345/174185371-a651b2a9-6d7c-47d1-8639-c9e26642b835.jpg" width="22%"></img>
  <img src="https://user-images.githubusercontent.com/74326345/174185407-b5af106d-613b-42be-8b29-dc80ece7ab7c.jpg" width="22%"></img>
  <img src="https://user-images.githubusercontent.com/74326345/174185436-a41617d1-4ee0-4930-bd93-8edd8394e7b1.jpg" width="22%"></img>
  <img src="https://user-images.githubusercontent.com/74326345/174185466-d37150cd-d900-450e-8066-f236b0b12785.jpg" width="22%"></img>
</p>

# What's That Anime

An **Image Search** App to find **Anime** Details related to the Image. Created using [Flutter](https://flutter.dev/), [Dart](https://dart.dev/) and API from [soruly](https://soruly.github.io/trace.moe-api/#/)

## Features

- Upload image to cloud
- Get Anime Details for uploaded image
- View and Manage History of all searches
- Customize App Behaviour from Settings Page

## Support

This package currently is only tested on android platform.

- [x] android
- [ ] ios
- [ ] web
- [ ] windows
- [ ] macos
- [ ] linux

## Whats Next?

- Add web platform support
- Add ios platform suppport

## How to Run

1. Clone the repo
   ```sh
   git clone https://github.com/OutdatedGuy/Whats-That-Anime.git
   ```
2. Install all the packages by typing
   ```sh
   flutter pub get
   ```
3. Create a [Firebase project](https://console.firebase.google.com/)
4. Enable _anonymous_ Auth, Firestore and Strorage for project.
5. Set **Firebase rules** for all paths to `true`. (temporarily, you can later add explicit permissions)
6. Then go to _Add App_ and select **Flutter** option and follow those instructions.
7. Run App
