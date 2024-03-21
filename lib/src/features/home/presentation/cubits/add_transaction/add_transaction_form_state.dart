part of 'add_transaction_form_cubit.dart';

class AddTransactionFormState extends Equatable {
  const AddTransactionFormState({
    this.amount = const Amount.pure(),
    this.category = const Category.pure(),
    this.description = const Description.pure(),
    this.date = const Date.pure(),
    this.isValid = false,
  });

  final Amount amount;
  final Category category;
  final Description description;
  final Date date;
  final bool isValid;

  AddTransactionFormState copyWith({
    final Amount? amount,
    final Category? category,
    final Description? description,
    final Date? date,
    final bool? isValid,
  }) {
    return AddTransactionFormState(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      isValid: isValid ?? this.isValid,
    );
  }

  IncomeEntity toIncomeEntity() {
    return IncomeEntity(
      category: category.value,
      description: description.value,
      amount: double.parse(amount.value),
      date: DateFormat('MMM d, y', 'en_US').parse(date.value),
    );
  }

  ExpenseEntity toExpenseEntity() {
    return ExpenseEntity(
      category: category.value,
      description: description.value,
      amount: -double.parse(amount.value),
      date: DateFormat('MMM d, y', 'en_US').parse(date.value),
    );
  }

  @override
  List<Object> get props => [amount, category, description, date, isValid];
}
