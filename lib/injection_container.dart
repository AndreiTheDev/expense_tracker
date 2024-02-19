import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import 'src/features/authentication/data/datasources/authentication_firebase_data_source.dart';
import 'src/features/authentication/data/datasources/authentication_firestore_data_source.dart';
import 'src/features/authentication/data/datasources/authentication_functions_data_source.dart';
import 'src/features/authentication/data/datasources/authentication_storage_data_source.dart';
import 'src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'src/features/authentication/data/repositories/profile_photos_repository_impl.dart';
import 'src/features/authentication/domain/repositories/authentication_repository.dart';
import 'src/features/authentication/domain/repositories/profile_photos_repository.dart';
import 'src/features/authentication/domain/usecases/delete_user.dart';
import 'src/features/authentication/domain/usecases/fetch_profile_photos_urls.dart';
import 'src/features/authentication/domain/usecases/is_signed_in_user.dart';
import 'src/features/authentication/domain/usecases/recover_password.dart';
import 'src/features/authentication/domain/usecases/sign_in_user.dart';
import 'src/features/authentication/domain/usecases/sign_out_user.dart';
import 'src/features/authentication/domain/usecases/sign_up_user.dart';
import 'src/features/authentication/presentation/blocs/user_bloc/user_bloc.dart';
import 'src/features/authentication/presentation/cubits/profile_photos_urls/profile_photos_urls_cubit.dart';
import 'src/features/authentication/presentation/cubits/recover_password_form/recover_password_form_cubit.dart';
import 'src/features/authentication/presentation/cubits/sign_in_form/sign_in_form_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Blocs
  sl
    ..registerFactory(
      () => UserBloc(
        isSignedInUser: sl(),
        signInUser: sl(),
        signUpUser: sl(),
        signOutUser: sl(),
        recoverPassword: sl(),
        deleteUser: sl(),
      ),
    )

    //Cubits
    ..registerFactory(() => ProfilePhotosUrlsCubit(profilePhotosUrls: sl()))
    ..registerFactory(SignInFormCubit.new)
    ..registerFactory(RecoverPasswordFormCubit.new)

    //Use Cases
    ..registerLazySingleton(() => DeleteUser(sl()))
    ..registerLazySingleton(() => IsSignedInUser(sl()))
    ..registerLazySingleton(() => RecoverPassword(sl()))
    ..registerLazySingleton(() => SignInUser(sl()))
    ..registerLazySingleton(() => SignOutUser(sl()))
    ..registerLazySingleton(() => SignUpUser(sl()))
    ..registerLazySingleton(() => FetchProfilePhotosUrls(sl()))

    //Repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        firebaseDataSource: sl(),
        firestoreDataSource: sl(),
        functionsDataSource: sl(),
        storageDataSource: sl(),
      ),
    )
    ..registerLazySingleton<ProfilePhotosRepository>(
      () => ProfilePhotosRepositoryImpl(storageDataSource: sl()),
    )

    //Data sources
    ..registerLazySingleton<AuthenticationFirebaseDataSource>(
      () => AuthenticationFirebaseDataSourceImpl(sl()),
    )
    ..registerLazySingleton<AuthenticationFirestoreDataSource>(
      () => AuthenticationFirestoreDataSourceImpl(sl()),
    )
    ..registerLazySingleton<AuthenticationFunctionsDataSource>(
      () => AuthenticationFunctionsDataSourceImpl(sl()),
    )
    ..registerLazySingleton<AuthenticationStorageDataSource>(
      () => AuthenticationStorageDataSourceImpl(sl()),
    )

    //Firebase instances
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseFunctions.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
