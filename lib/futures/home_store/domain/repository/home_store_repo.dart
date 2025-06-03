import 'package:dartz/dartz.dart';

import '../../../../core/networke/network_exception.dart';
import '../entity/home_store_entity.dart';

abstract class  HomeStoreRepo {
  Future<Either<Failure, List<HomeStoreEntity>>> getHomeStoreData();
}