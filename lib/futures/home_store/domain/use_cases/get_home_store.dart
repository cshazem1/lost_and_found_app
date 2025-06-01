import 'package:dartz/dartz.dart';
import 'package:lost_and_found_app/futures/home_store/domain/entity/home_store_entity.dart';

import '../../../../core/networke/network_exception.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/home_store_repo.dart';

class GetHomeStore extends UseCase<Future<Either<Failure, List<HomeStoreEntity>>>, NoParams>{
  GetHomeStore(this.homeStoreRepo);
  final HomeStoreRepo homeStoreRepo;

  @override
  Future<Either<Failure, List<HomeStoreEntity>>> call(NoParams params) {
    return homeStoreRepo.getHomeStoreData();
  }


}