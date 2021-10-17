function ci_projects () {
    local channel="$1"

    shift
    local arr=("$@")
    for PROJECT_NAME in "${arr[@]}"
    do
        echo "== Testing '${PROJECT_NAME}' on Flutter's $channel channel =="
        pushd "${PROJECT_NAME}"

        # Grab packages.
        flutter pub get

        if [ "${PROJECT_NAME}" == "."]
        then
            flutter packages pub run build_runner build
        fi

        # Run the analyzer to find any static analysis issues.
        dart analyze

        # Run the formatter on all the dart files to make sure everything's linted.
        # Do not format generated dart code
        find . -name "*.dart" ! -path './package/hello_spec/*' | xargs dart format --set-exit-if-changed

        # Generate dart code for protos
        if [ "${PROJECT_NAME}" == "package/hello_spec" ]
        then
            dart pub global activate protoc_plugin
            echo "$PUB_CACHE/bin" >> GITHUB_PATH
            find . -name "*.proto" | xargs -I {} protoc -I=lib --dart_out=lib/generated "{}"
        fi

        # Run the actual tests.
        if [ -d "test" ]
        then
            flutter test
        fi

        popd
    done
}