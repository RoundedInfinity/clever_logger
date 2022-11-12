import 'package:clever_logger/clever_logger.dart';

/// {@template log_action}
/// A abstract class that represents a action taken
/// when a new log record is recieved.
///
/// See also:
/// - [CleverLogger] the logger that uses these actions.
/// - [ColorfulPrintAction] a action that prints its
///   logs to the console in color.
/// {@endtemplate}
abstract class LogAction {
  /// {@macro log_action}
  const LogAction({this.level = Level.ALL});

  /// The minimum level this action requires to get called.
  ///
  /// For example when this is [Level.WARNING] and a log only has [Level.FINE]
  /// [onRecord] will not be called.
  final Level level;

  /// A function called when the [CleverLogger]
  /// recieved a new log (for example when `logInfo` gets called).
  void onRecord(LogRecord record) {}
}

/// {@template colorful_print_action}
/// A [LogAction] that prints the recieved [LogRecord]
/// to the console using a [CleverPrinter].
/// {@endtemplate}
class ColorfulPrintAction extends LogAction {
  /// {@macro colorful_print_action}
  const ColorfulPrintAction({
    this.printer = const CleverPrinter(),
    super.level = Level.ALL,
  });

  /// The printer used to print the logs.
  final CleverPrinter printer;
  @override
  void onRecord(LogRecord record) {
    printer.printLogRecord(record);
  }
}
