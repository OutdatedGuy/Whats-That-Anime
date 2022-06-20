# Contributing

Contributions to this project are [released][github-tos] to the public under the [project's open source license](LICENSE).

This project adheres to a [Code of Conduct][code-of-conduct]. By participating, you are expected to honor this code.

[code-of-conduct]: CODE_OF_CONDUCT.md

## Submitting a Pull Request

1. Fork this repo.
1. Follow steps to [clone and run project](README.md#how-to-run).
1. Create a branch (`git checkout -b my_branch`).
1. Commit your changes (`git commit -am "Added new feature"`).
1. Push to the branch (`git push origin my_branch`).
1. Open a [Pull Request][pull-request].
1. Enjoy a pleasant sleep.

## Linter

To run the linter:

```sh
flutter analyze
```

If nothing complains, congratulations!

## Releasing a new version

If you are the current maintainer of this repo:

1. Download changes locally (`git pull`)
1. Test the latest version locally with `flutter run`
1. Build the new version locally with `flutter build appbundle`
1. Update `CHANGELOG.md`
1. Bump the version number in `pubspec.yaml`, adhering to [Semantic Versioning](http://semver.org/)
1. Push the new version to the `main` branch (`git push origin main`)

[pull-request]: https://github.com/OutdatedGuy/Whats-That-Anime/pulls
[github-tos]: https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license
