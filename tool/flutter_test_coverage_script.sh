#!/bin/bash

set -e

DIR="${BASH_SOURCE%/*}"

# install lcov
sudo apt-get install lcov

# coverage for package/hello_spec
echo "== Testing 'package/hello_spec' on Flutter's stable channel =="
pushd package/hello_spec

flutter pub get
dart pub global activate protoc_plugin
echo "$PUB_CACHE/bin" >> GITHUB_PATH
find . -name "*.proto" | xargs -I {} protoc -I=lib --dart_out=lib/generated "{}"
flutter test --coverage --coverage-path=../../coverage/lcov.base.info

popd

# coverage for .
echo "== Testing '.' on Flutter's stable channel =="
pushd .

flutter pub get
flutter packages pub run build_runner build
flutter test --coverage --merge-coverage

popd

echo "-- Success --"