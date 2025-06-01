import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:lost_and_found_app/core/networke/network_exception.dart';
import 'package:lost_and_found_app/futures/home_store/data/data_source/home_store_data_source.dart';

import 'package:lost_and_found_app/futures/home_store/domain/entity/home_store_entity.dart';

import '../../domain/repository/home_store_repo.dart';

@Injectable(as: HomeStoreRepo)
class HomeStoreRepoImp extends HomeStoreRepo {
  HomeStoreDataSource homeStoreDataSource;
  HomeStoreRepoImp(this.homeStoreDataSource);

  @override
  Future<Either<Failure, List<HomeStoreEntity>>> getHomeStoreData() async {
    try {
      final data = await homeStoreDataSource.getHomeStoreData();
      return Right(data.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
