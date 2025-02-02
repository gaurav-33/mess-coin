import 'package:logger/logger.dart';

class AppLogger {
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Stack trace lines for errors
      lineLength: 120, // Set max line width
      colors: true, // Enable colored logs
      printEmojis: true, // ✅ Enable built-in emojis
      printTime: true, // 🕒 Show timestamps
    ),
  );

  static void v(dynamic message) => logger.v(message); // Verbose (🔍)
  static void d(dynamic message) => logger.d(message); // Debug (🐛)
  static void i(dynamic message) => logger.i(message); // Info (ℹ️)
  static void w(dynamic message) => logger.w(message); // Warning (⚠️)
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      logger.e(message, error: error, stackTrace: stackTrace); // Error (❌)
  static void f(dynamic message) => logger.f(message); // Fatal (🔥)
}
