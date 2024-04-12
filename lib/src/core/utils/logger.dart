import 'package:logger/logger.dart';

Logger getLogger(final Type classType) {
  return Logger(printer: MyPrinter(classType.toString()));
}

class MyPrinter extends LogPrinter {
  final String className;
  MyPrinter(this.className);

  @override
  List<String> log(final LogEvent event) {
    final AnsiColor color = PrettyPrinter.defaultLevelColors[event.level]!;
    final String? emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    return <String>[
      color('${event.level}  $emoji $className - ${event.message}'),
    ];
  }
}
