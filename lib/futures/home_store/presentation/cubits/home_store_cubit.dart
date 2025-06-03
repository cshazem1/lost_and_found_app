import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/networke/network_exception.dart';
import '../../domain/entity/home_store_entity.dart';
import '../../domain/repository/home_store_repo.dart';

part 'home_store_state.dart';

@lazySingleton
class HomeStoreCubit extends Cubit<HomeStoreState> {
  HomeStoreCubit(this.homeStoreRepo) : super(HomeStoreInitial());
  final HomeStoreRepo homeStoreRepo;

  Future<void> getHomeStoreData() async {
    emit(HomeStoreLoading());
    final result = await homeStoreRepo.getHomeStoreData();
    result.fold(
      (data) => emit(HomeStoreError(data)),
      (error) => emit(HomeStoreLoaded(error)),
    );
  }
}
