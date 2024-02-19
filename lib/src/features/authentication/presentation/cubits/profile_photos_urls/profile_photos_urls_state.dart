part of 'profile_photos_urls_cubit.dart';

sealed class ProfilePhotosUrlsState extends Equatable {
  const ProfilePhotosUrlsState();

  @override
  List<Object> get props => [];
}

final class ProfilePhotosUrlsInitial extends ProfilePhotosUrlsState {}

final class ProfilePhotosUrlsLoading extends ProfilePhotosUrlsState {}

final class ProfilePhotosUrlsLoaded extends ProfilePhotosUrlsState {
  final List<String> urls;

  const ProfilePhotosUrlsLoaded({required this.urls});

  @override
  List<Object> get props => [urls];
}

final class ProfilePhotosUrlsError extends ProfilePhotosUrlsState {
  final String message;

  const ProfilePhotosUrlsError({required this.message});

  @override
  List<Object> get props => [message];
}
