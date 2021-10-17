import 'package:hello/hello_service.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HelloService)
class HelloServiceImpl implements HelloService {
  @override
  String sayHello(Hello hello) {
    if (hello.hasName()) {
      return 'Hello, ${hello.name}!';
    }
    return 'Hello, Anonymous!';
  }
}
