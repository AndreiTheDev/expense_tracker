import 'package:intl/intl.dart';

List<String> monthlyThresholdToAmountIntervalTexts(
  final double monthlyThreshold, [
  final double listLength = 5,
]) {
  final amountFormatter = NumberFormat.compact(locale: 'en_US');
  final step = monthlyThreshold / listLength;
  final amountIntervalTextsList = <String>[];
  for (var i = 1; i <= listLength; i++) {
    amountIntervalTextsList.add(amountFormatter.format(i * step));
  }
  return amountIntervalTextsList;
}
