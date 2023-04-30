// ignore_for_file: avoid_print

import 'package:ansicolor/ansicolor.dart';
import 'package:clever_logger/clever_logger.dart';

/// A class that formats and prints [LogRecord]s styled in a colorful way.
class CleverPrinter {
  /// A class that formats and prints [LogRecord]s styled in a colorful way.
  const CleverPrinter();

  /// Prints out the [record] with a style depending on its [Level].
  ///
  /// When no [Level] fits, the [record] is printed with [printDefault].
  void printLogRecord(LogRecord record) {
    ansiColorDisabled = false;
    if (record.level == Level.INFO) {
      return printInfo(record);
    }
    if (record.level == Level.WARNING) {
      return printWarning(record);
    }
    if (record.level == Level.SHOUT) {
      return printShout(record);
    }
    if (record.level == Level.CONFIG) {
      return printConfig(record);
    }
    if (record.level == Level.SEVERE) {
      return printSevere(record);
    }
    if (record.level == Level.FINE) {
      return printFine(record);
    }

    return printDefault(record);
  }

  /// Prints the [record] at level [Level.INFO].
  void printInfo(LogRecord record) {
    final pen = AnsiPen()..xterm(012);
    print(pen('[${record.loggerName} - INFO] ${record.message}'));
  }

  /// Prints the [record] at level [Level.WARNING].
  void printWarning(LogRecord record) {
    final pen = AnsiPen()..xterm(209);
    print(pen('[${record.loggerName} - WARNING] ${record.message}'));
  }

  /// Prints the [record] at level [Level.SHOUT].
  void printShout(LogRecord record) {
    final pen = AnsiPen()..xterm(013);

    print(pen('[${record.loggerName} - SHOUT] ${record.message}'));
  }

  /// Prints the [record] at level [Level.CONFIG].
  void printConfig(LogRecord record) {
    final pen = AnsiPen()..xterm(007);
    print(pen('[${record.loggerName} - CONFIG] ${record.message}'));
  }

  /// Prints the [record] at level [Level.FINE].
  void printFine(LogRecord record) {
    final pen = AnsiPen()..xterm(008);
    print(pen('[${record.loggerName} - FINE] ${record.message}'));
  }

  /// Prints the [record] at level [Level.SEVERE].

  void printSevere(LogRecord record) {
    final pen = AnsiPen()..xterm(001);
    print(pen('[${record.loggerName} - SEVERE] ${record.message}'));
    if (record.stackTrace != null) {
      print(pen(record.stackTrace!));
    }
  }

  /// Prints the [record] when no other level fits.
  void printDefault(LogRecord record) {
    final pen = AnsiPen()..xterm(008);
    print(pen('[${record.loggerName} - ${record.level}] ${record.message}'));
  }
}

/// A class that formats and prints [LogRecord]s styled with emojis 🚀.
class EmojiPrinter extends CleverPrinter {
  /// A class that formats and prints [LogRecord]s styled with emojis 🚀.
  const EmojiPrinter();
  @override
  void printDefault(LogRecord record) {
    final pen = AnsiPen()..xterm(008);
    print(pen('[ 🖨️ ${record.loggerName}] ${record.message}'));
  }

  @override
  void printFine(LogRecord record) {
    final pen = AnsiPen()..xterm(008);
    print(pen('[ 📝 ${record.loggerName}] ${record.message}'));
  }

  @override
  void printInfo(LogRecord record) {
    final pen = AnsiPen()..xterm(012);
    print(pen('[ 💡 ${record.loggerName}] ${record.message}'));
  }

  @override
  void printConfig(LogRecord record) {
    final pen = AnsiPen()..xterm(007);
    print(pen('[ ⚙️ ${record.loggerName}] ${record.message}'));
  }

  @override
  void printWarning(LogRecord record) {
    final pen = AnsiPen()..xterm(209);
    print(pen('[ ⚠️ ${record.loggerName}] ${record.message}'));
  }

  @override
  void printSevere(LogRecord record) {
    final pen = AnsiPen()..xterm(001);
    print(pen('[ ⛔ ${record.loggerName}] ${record.message}'));
    if (record.stackTrace != null) {
      print(pen(record.stackTrace!));
    }
  }

  @override
  void printShout(LogRecord record) {
    final pen = AnsiPen()..xterm(013);

    print(pen('[ 📣 ${record.loggerName}] ${record.message}'));
  }
}
