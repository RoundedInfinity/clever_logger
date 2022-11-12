import 'package:clever_logger/clever_logger.dart';

/// The defualt [CleverLogger] used when calling unnamed functions
/// like [log] or [logInfo].
late final CleverLogger defaultLogger;

/// Logs a message with the [defaultLogger] at [level].
void log(Object? message, [Level level = Level.FINE]) {
  try {
    defaultLogger.log(message, level);
  } catch (e) {
    defaultLogger = CleverLogger('Logger');
    defaultLogger.log(message, level);
  }
}

/// Logs a message with the [defaultLogger] at [Level.FINE].
void logFine(Object? message) => log(message);

/// Logs a message with the [defaultLogger] at [Level.INFO].
void logInfo(Object? message) => log(message, Level.INFO);

/// Logs a message with the [defaultLogger] at [Level.CONFIG].
void logConfig(Object? message) => log(message, Level.CONFIG);

/// Logs a message with the [defaultLogger] at [Level.WARNING].
void logWarning(Object? message) => log(message, Level.WARNING);

/// Logs a message with the [defaultLogger] at [Level.SEVERE].
void logSevere(Object? message) => log(message, Level.SEVERE);

/// Logs a message with the [defaultLogger] at [Level.SHOUT].
void logShout(Object? message) => log(message, Level.SHOUT);
