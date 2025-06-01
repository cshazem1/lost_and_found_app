import 'package:injectable/injectable.dart';
import 'package:lost_and_found_app/core/networke/dio_helper.dart';
import 'package:lost_and_found_app/futures/home_store/data/models/home_store_model.dart';

import '../../../../core/networke/end_points.dart';

abstract class HomeStoreDataSource {
  Future<List<HomeStoreModel>> getHomeStoreData();
}

@LazySingleton(as: HomeStoreDataSource)
class HomeStoreDataSourceImpl implements HomeStoreDataSource {
  BaseDioHelper dioHelper;
  HomeStoreDataSourceImpl(this.dioHelper);
  @override
  Future<List<HomeStoreModel>> getHomeStoreData() {
    final response = dioHelper.get(endPoint: EndPoints.homeStore);

    return response.then((value) {
      return (value.data as List).map((e) => HomeStoreModel.fromJson(e)).toList();
    });

  }

}