// ignore_for_file: cascade_invocations

import 'package:clever_logger/clever_logger.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

class _CollectingLogAction extends LogAction {
  _CollectingLogAction();

  final records = <LogRecord>[];
  @override
  void onRecord(LogRecord record) {
    records.add(record);
  }
}

void main() {
  group('CleverLogger', () {
    test('Can be used', () {
      final logger = CleverLogger('Test', logActions: []);

      expect(logger, isNotNull);
    });
    test('Can log and CollectingLogAction works', () {
      final action = _CollectingLogAction();
      final logger = CleverLogger('Test', logActions: [action]);

      expect(action.records, isEmpty);

      logger.log('YEe');
      expect(action.records, isNotEmpty);
    });

    test('Logging right level', () {
      final action = _CollectingLogAction();
      final logger = CleverLogger('Test', logActions: [action]);

      logger.logFine('yee');
      logger.logConfig('yee');
      logger.logInfo('yee');
      logger.logWarning('yee');
      logger.logSevere('yee');
      logger.logShout('yee');

      expect(action.records[0].level, equals(Level.FINE));
      expect(action.records[1].level, equals(Level.CONFIG));
      expect(action.records[2].level, equals(Level.INFO));
      expect(action.records[3].level, equals(Level.WARNING));
      expect(action.records[4].level, equals(Level.SEVERE));
      expect(action.records[5].level, equals(Level.SHOUT));
    });

    test('Can use multiple loggers', () {
      final action = _CollectingLogAction();
      final logger1 = CleverLogger('Test 1', logActions: [action]);
      final logger2 = CleverLogger('Test 2', logActions: [action]);
      logger1.logInfo('1');
      logger2.logInfo('2');

      expect(action.records.length, equals(2));
    });

    test('Can use stacktraces and errors', () {
      final action = _CollectingLogAction();
      final logger = CleverLogger('Test 1', logActions: [action]);
      logger.logWarning(
        'FUUUU',
        error: Exception('NONO'),
        stackTrace: StackTrace.current,
      );

      expect(action.records.first.stackTrace, isNotNull);
      expect(action.records.first.error, isNotNull);
    });
  });

  group('Default logger', () {
    test('Can use default logger without init', () {
      expect(() => log('Hi'), returnsNormally);
    });
  });
}
