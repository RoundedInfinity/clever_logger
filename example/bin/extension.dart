import 'package:clever_logger/clever_logger.dart';

/// Extension used to implement a counting function to the logger.
extension CountExtention on CleverLogger {
  /// Increase the value for [name] by [amount] and log it.
  void countUp([String name = 'count', int amount = 1]) {
    // Mark this key as part of this extension
    // by using `count_` as a prefix.
    final key = 'count_$name';

    // [values] can be used to store additional values in the logger.
    final val = values[key] as int?;

    values[key] = (val ?? 0) + amount;

    this.logInfo('Increased [$name] to: ${values[key]}');
  }

  /// Decrease the value for [name] by [amount] and log it.
  void countDown([String name = 'count', int amount = 1]) {
    final val = values[name] as int?;
    final key = 'count_$name';
    values[key] = (val ?? 0) - amount;

    this.logInfo('Decreased [$name] to: ${values[key]}');
  }

  /// Resets the value for [name] to 0 and log it.
  void resetCount([String name = 'count']) {
    final key = 'count_$name';
    values[key] = 0;

    this.logInfo('Reset [$name] to: 0');
  }
}
