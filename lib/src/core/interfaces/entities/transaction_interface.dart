abstract interface class ITransactionEntity {
  String get id;
  String get category;
  String get description;
  double get amount;
  DateTime get date;
  String get relatedDoc;
}
