import 'package:logging/logging.dart';

import 'biz_function.dart';

Future<void> runApp(var message) async {
  var stopwatch = Stopwatch()..start();

  // Do something

  print('Execution($message) Time: ${stopwatch.elapsed.inMilliseconds}ms');
  stopwatch.stop();
}

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time} ${record.level.name.padLeft(6, ' ')} [${record.loggerName}] : ${record.message}');
    if (record.error != null) print(record.error);
    if (record.stackTrace != null) print(record.stackTrace);
  });

  var biz = Biz();
  biz.runAll();

  //var logger = Logger("child");

  //Logger.root.info("Some message");

  //logger.info("More messahe");

  // var concurrency = 6000;

  // for (var i = 0; i < concurrency; i++) {
  //   Isolate.spawn(runApp, 'Instance_$i');
  // }

  // await Future.delayed(const Duration(seconds: 10));

  //print("Exit");
}
