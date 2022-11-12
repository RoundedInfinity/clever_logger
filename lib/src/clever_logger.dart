import 'package:clever_logger/src/log_action.dart';
import 'package:logging/logging.dart';

/// {@template clever_logger}
/// A logger that prints colorful logs by default.
///
/// The logger can log messages in different levels.
/// {@endtemplate}
///
/// {@template clever_logger_example}
/// **Example**
///```dart
///final logger = CleverLogger('Test Logger');
///logger.logInfo('This is a info');
///logger.logWarning('This is a warning');
///```
///
/// You can also define actions for the logs.
///```dart
/// final loggerWithCustomActions = CleverLogger(
///   'Test Logger',
///   logActions: [
///     ColorfulPrintAction(),
///     // Your custom action
///     // (Actions can be configured to only be triggered when the log has a certain level)
///     MySendToFirebaseAction(),
///   ],
/// );
///```
/// {@endtemplate}
///
/// {@template clever_logger_end}
///
/// Alternatively you can use the [defaultLogger]
/// by just calling [log] (or [logInfo], [logWarning] etc.).
///
/// See also:
/// - [LogAction] an action taken with the log.
///  You can extend this class for custom actions.
/// - [ColorfulPrintAction] the defualt action used for this logger.
///  You can customize its printer argument for a customized color output.
/// {@endtemplate}
class CleverLogger {
  /// {@macro clever_logger}
  ///
  /// [name] is the idedntifier of the logger.
  /// Loggers should not have the same name.
  ///
  /// [logActions] are responsible for what happens with the logs.
  /// The [LogRecord]s are passed to the actions in order.
  /// By default the logger uses a [ColorfulPrintAction] as its default action,
  /// which is responsible for colorful outputs to the console.
  ///
  /// {@macro clever_logger_example}
  ///
  /// {@macro clever_logger_end}
  CleverLogger(
    String name, {
    List<LogAction> logActions = const [
      ColorfulPrintAction(),
    ],
  }) {
    hierarchicalLoggingEnabled = true;

    _logger = Logger(name);
    _logger.level = Level.ALL;

    _logger.onRecord.listen(
      (record) {
        for (final action in logActions) {
          if (action.level <= record.level) {
            action.onRecord(record);
          }
        }
      },
    );
  }

  late final Logger _logger;

  /// Additional values stored in this logger.
  /// Can be used to store data for extension methods.
  final Map<String, dynamic> values = {};

  /// Logs a message at [level].
  void log(Object? message, [Level level = Level.FINE]) {
    _logger.log(level, message);
  }

  /// Logs a message at [Level.FINE].
  void logFine(Object? message) => log(message);

  /// Logs a message at [Level.INFO].
  void logInfo(Object? message) => log(message, Level.INFO);

  /// Logs a message at [Level.CONFIG].
  void logConfig(Object? message) => log(message, Level.CONFIG);

  /// Logs a message at [Level.WARNING].
  void logWarning(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.log(Level.WARNING, message, error, stackTrace);

  /// Logs a message at [Level.SEVERE].
  void logSevere(Object? message) => log(message, Level.SEVERE);

  /// Logs a message at [Level.SHOUT].
  void logShout(Object? message) => log(message, Level.SHOUT);
}
