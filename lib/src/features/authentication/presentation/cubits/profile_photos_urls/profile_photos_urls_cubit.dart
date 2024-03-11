import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/fetch_profile_photos_urls.dart';

part 'profile_photos_urls_state.dart';

class ProfilePhotosUrlsCubit extends Cubit<ProfilePhotosUrlsState> {
  ProfilePhotosUrlsCubit({required FetchProfilePhotosUrls profilePhotosUrls})
      : _profilePhotosUrls = profilePhotosUrls,
        super(ProfilePhotosUrlsInitial());

  final FetchProfilePhotosUrls _profilePhotosUrls;

  Future<void> fetchProfilePhotosUrls() async {
    emit(ProfilePhotosUrlsLoading());
    final response = await _profilePhotosUrls();
    response.fold(
      (l) => emit(ProfilePhotosUrlsError(message: l.message)),
      (r) => emit(ProfilePhotosUrlsLoaded(urls: r)),
    );
  }
}
