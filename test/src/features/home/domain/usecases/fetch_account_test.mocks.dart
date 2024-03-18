// Mocks generated by Mockito 5.4.4 from annotations
// in expense_tracker_app_bloc/test/src/features/home/domain/usecases/fetch_account_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:expense_tracker_app_bloc/src/core/error/failures.dart' as _i5;
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart'
    as _i6;
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart'
    as _i8;
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart'
    as _i9;
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart'
    as _i10;
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart'
    as _i2;
import 'package:fpdart/fpdart.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AccountRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountRepository extends _i1.Mock implements _i2.AccountRepository {
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.AccountEntity>> fetchAccount(
          {String? id = r'defaultAccount'}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAccount,
          [],
          {#id: id},
        ),
        returnValue:
            _i3.Future<_i4.Either<_i5.Failure, _i6.AccountEntity>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.AccountEntity>>(
          this,
          Invocation.method(
            #fetchAccount,
            [],
            {#id: id},
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, _i6.AccountEntity>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.AccountEntity>>(
          this,
          Invocation.method(
            #fetchAccount,
            [],
            {#id: id},
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.AccountEntity>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> addExpense({
    required String? accountId,
    required _i8.ExpenseEntity? expenseEntity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addExpense,
          [],
          {
            #accountId: accountId,
            #expenseEntity: expenseEntity,
          },
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #addExpense,
            [],
            {
              #accountId: accountId,
              #expenseEntity: expenseEntity,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #addExpense,
            [],
            {
              #accountId: accountId,
              #expenseEntity: expenseEntity,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> addIncome({
    required String? accountId,
    required _i9.IncomeEntity? incomeEntity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addIncome,
          [],
          {
            #accountId: accountId,
            #incomeEntity: incomeEntity,
          },
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #addIncome,
            [],
            {
              #accountId: accountId,
              #incomeEntity: incomeEntity,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #addIncome,
            [],
            {
              #accountId: accountId,
              #incomeEntity: incomeEntity,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> deleteExpense({
    required String? accountId,
    required _i8.ExpenseEntity? expenseEntity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteExpense,
          [],
          {
            #accountId: accountId,
            #expenseEntity: expenseEntity,
          },
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteExpense,
            [],
            {
              #accountId: accountId,
              #expenseEntity: expenseEntity,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteExpense,
            [],
            {
              #accountId: accountId,
              #expenseEntity: expenseEntity,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> deleteIncome({
    required String? accountId,
    required _i9.IncomeEntity? incomeEntity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteIncome,
          [],
          {
            #accountId: accountId,
            #incomeEntity: incomeEntity,
          },
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteIncome,
            [],
            {
              #accountId: accountId,
              #incomeEntity: incomeEntity,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteIncome,
            [],
            {
              #accountId: accountId,
              #incomeEntity: incomeEntity,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> deleteTransaction({
    required String? accountId,
    required _i10.TransactionEntity? transactionEntity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteTransaction,
          [],
          {
            #accountId: accountId,
            #transactionEntity: transactionEntity,
          },
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteTransaction,
            [],
            {
              #accountId: accountId,
              #transactionEntity: transactionEntity,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteTransaction,
            [],
            {
              #accountId: accountId,
              #transactionEntity: transactionEntity,
            },
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);
}
