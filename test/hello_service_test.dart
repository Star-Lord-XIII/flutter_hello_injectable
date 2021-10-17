import 'package:flutter_test/flutter_test.dart';
import 'package:hello/hello_service.dart';
import 'package:hello/injection.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';

void main() {
  setUpAll(() => configureDependencies());

  group('HelloService#sayHello test', () {
    test('hello with a name', () {
      var helloStub = getIt<HelloService>();
      expect(
          helloStub.sayHello(Hello.create()
            ..id = 1
            ..name = 'Chintan Ghate'),
          'Hello, Chintan Ghate!');
    });

    test('anonymous hello', () {
      var helloStub = getIt<HelloService>();
      expect(helloStub.sayHello(Hello.create()..id = 2), 'Hello, Anonymous!');
    });
  });
}
