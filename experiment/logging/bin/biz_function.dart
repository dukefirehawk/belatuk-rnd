import 'package:logging/logging.dart';

class Biz {
  var logger = Logger("child");

  void runAll() {
    _run1();
    _run2();
    _run3();
    _run4();
    _run5();
    _run6();
  }

  void _run1() {
    logger.finest("Run finest");
  }

  void _run2() {
    logger.finer("Run finer");
  }

  void _run3() {
    logger.fine("Run fine");
  }

  void _run4() {
    logger.info("Run info");
  }

  void _run5() {
    logger.severe("Run severe");
  }

  void _run6() {
    logger.shout("Run shout");
  }
}
