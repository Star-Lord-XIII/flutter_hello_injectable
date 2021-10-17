import 'package:hello_spec/generated/proto/hello.pb.dart';

abstract class HelloService {
  String sayHello(Hello hello);
}
