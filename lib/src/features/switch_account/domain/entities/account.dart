import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final String? owner;
  final double totalBalance;

  AccountEntity({
    required this.name,
    required this.totalBalance,
    this.owner,
    String? id,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [
        id,
        name,
        totalBalance,
        owner,
      ];
}
