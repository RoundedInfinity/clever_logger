import 'package:clever_logger/src/clever_logger.dart';

/// Extention for [CleverLogger] that implements a stopwatch to measure time.
extension StopwatchExtension on CleverLogger {
  Stopwatch get _watch {
    final watch = values['_stopwatch'] as Stopwatch?;
    if (watch == null) {
      values.addAll({'_stopwatch': Stopwatch()});
      return values['_stopwatch'] as Stopwatch;
    }
    return watch;
  }

  /// Starts a [Stopwatch] in this logger.
  ///
  /// This is easy way to track the time between different events.
  ///
  /// To pasue the stopwatch, call [pauseWatch].
  /// To finish the watch, call [finishWatch].
  void startWatch() {
    _watch.start();
    logInfo('Stopwatch started');
  }

  /// Stops a [Stopwatch] in this logger.
  ///
  /// See also:
  /// - [startWatch]
  /// - [finishWatch]
  void pauseWatch() {
    _watch.stop();
    logInfo('Stopwatch paused');
  }

  /// Stop and reset the [Stopwatch] and log its results.
  ///
  /// This will log how much time and how many ticks are elapsed.
  void finishWatch() {
    logInfo(
      // ignore: lines_longer_than_80_chars
      'Stopwatch stopped: ${_watch.elapsed} elapsed (${_watch.elapsedTicks} ticks)',
    );

    _watch
      ..stop()
      ..reset();
  }
}
