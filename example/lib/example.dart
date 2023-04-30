import 'package:clever_logger/clever_logger.dart';
import 'package:clever_logger/extension.dart';

import 'extension.dart';

// This is your logger. You can define them global or local.
final logger = CleverLogger('Test Logger', logActions: [
  ColorfulPrintAction(
    printer: EmojiPrinter(),
  ),
]);

void main(List<String> arguments) async {
  // The default logger is used for unnamed logging with the `log()` function.
  // It is optional to configure the default logger, like done here.
  // Alternatively you can use the default logger right away without setting its value.
  // defaultLogger = CleverLogger('Default Logger');

  // This is using the default logger
  logInfo('Hello there');

  logger.log('Something not important', Level.FINE);
  logger.log('This is a info', Level.INFO);
  logger.log('This is a config', Level.CONFIG);
  logger.log(Exception('Oh ho'), Level.WARNING);

  logger.log('This is severe', Level.SEVERE);
  logger.log('This is a LOUD', Level.SHOUT);

  final otherLogger = CleverLogger(
    'Other Logger',
    logActions: [
      // The default colorful console output.
      ColorfulPrintAction(),
      // A custom action
      MyLogAction(),
    ],
  );

  otherLogger.logFine('A message');

  // This will run `onRecord` for [MyLogAction]
  otherLogger.logWarning('Another one');

  // Uses a default extension on this logger for using a stopwatch
  logger.startWatch();
  await Future.delayed(const Duration(milliseconds: 500));
  logger.finishWatch();

  // A custom extension to use this logger to count up.
  // See extension.dart in the example folder to see
  // how to create extensions for [CleverLogger]
  logger.countUp();
  logger.countUp('other');
  logger.resetCount('other');
}

class MyLogAction extends LogAction {
  @override
  Level get level => Level.INFO;

  @override
  void onRecord(LogRecord record) {
    //This is only executed for logs with a level >= Level.info
    print('${record.loggerName} has a log with ${record.level}');
  }
}
