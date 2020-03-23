import 'package:syncfusion_flutter_core/core.dart';
import 'package:logging/logging.dart';

class Utils {
  static void setUp() {
    Logger logger = Logger.root;
    logger.onRecord.listen((event) {
      print(
          '${event.time}: ${event.level}: ${event.loggerName} -> ${event.message}');
    });
    SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31ifWN9YGVoYmF8YGJ8ampqanNiYmlmamlmanMDHmgxNicnNzwmNBM0PjI6P30wPD4=',
    );
  }
}
