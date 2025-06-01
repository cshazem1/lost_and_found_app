part of 'home_store_cubit.dart';

@immutable
sealed class HomeStoreState {}

final class HomeStoreInitial extends HomeStoreState {}

final class HomeStoreLoading extends HomeStoreState {}

final class HomeStoreLoaded extends HomeStoreState {
  final List<HomeStoreEntity> data;
  HomeStoreLoaded(this.data);
}

final class HomeStoreError extends HomeStoreState {
  final Failure failure;
  HomeStoreError(this.failure);
}