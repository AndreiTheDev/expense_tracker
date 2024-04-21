import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/account.dart';

import '../../domain/repository/switch_account_repository.dart';
import '../datasources/switch_account_firebase_datasource.dart';
import '../datasources/switch_account_firestore_datasource.dart';
import '../dtos/account.dart';

class SwitchAccountRepositoryImpl implements SwitchAccountRepository {
  final SwitchAccountFirebaseDataSource _firebaseDataSource;
  final SwitchAccountFirestoreDataSource _firestoreDataSource;

  final Logger _logger = getLogger(SwitchAccountRepositoryImpl);

  SwitchAccountRepositoryImpl(
    this._firebaseDataSource,
    this._firestoreDataSource,
  );

  @override
  Future<Either<Failure, void>> createNewAccount(
    AccountEntity accountEntity,
  ) async {
    _logger.d(
      'createNewAccount - called - params: {accountName: $accountEntity}',
    );
    try {
      final user = _firebaseDataSource.getUser();
      await _firestoreDataSource.createNewAccount(
        user.uid,
        AccountDto.fromEntity(accountEntity).toJson(),
      );
      return const Right(null);
    } on SwitchAccountFailure catch (e) {
      _logger.e('fetchAccountsList - SwitchAccountFailure: ${e.message}');
      return Left(e);
    } on FirebaseException catch (e) {
      _logger.e('fetchAccountsList - FirebaseException: ${e.code}');
      return Left(SwitchAccountFailure.fromFirestoreException(e.code));
    } on Exception {
      _logger.e('fetchAccountsList - an unknown error occured.');
      return const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      );
    }
  }

  @override
  Future<Either<Failure, List<AccountEntity>>> fetchAccountsList() async {
    _logger.d('fetchAccountsList - called - params: empty');
    try {
      final user = _firebaseDataSource.getUser();
      final responseList =
          await _firestoreDataSource.fetchAccountsList(user.uid);
      final accountsList = responseList.map(AccountDto.fromJson).toList();
      return Right(accountsList);
    } on SwitchAccountFailure catch (e) {
      _logger.e('fetchAccountsList - SwitchAccountFailure: ${e.message}');
      return Left(e);
    } on FirebaseException catch (e) {
      _logger.e('fetchAccountsList - FirebaseException: ${e.code}');
      return Left(SwitchAccountFailure.fromFirestoreException(e.code));
    } on Exception {
      _logger.e('fetchAccountsList - an unknown error occured.');
      return const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      );
    }
  }
}
