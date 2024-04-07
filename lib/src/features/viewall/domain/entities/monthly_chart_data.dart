// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MonthlyChartDataEntity extends Equatable {
  final double balance;
  final DateTime date;

  const MonthlyChartDataEntity({
    required this.balance,
    required this.date,
  });

  @override
  List<Object?> get props => [balance, date];
}
