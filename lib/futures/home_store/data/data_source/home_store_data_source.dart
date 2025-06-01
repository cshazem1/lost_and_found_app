import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lost_and_found_app/core/networke/dio_helper.dart';
import 'package:lost_and_found_app/futures/home_store/data/models/home_store_model.dart';

import '../../../../core/networke/end_points.dart';
import '../../../../core/networke/network_exception.dart';

abstract class HomeStoreDataSource {
  Future<List<HomeStoreModel>> getHomeStoreData();
}

@LazySingleton(as: HomeStoreDataSource)
class HomeStoreDataSourceImpl implements HomeStoreDataSource {
  BaseDioHelper dioHelper;
  HomeStoreDataSourceImpl(this.dioHelper);
  @override
  Future<List<HomeStoreModel>> getHomeStoreData() async {
    try {
      final response = await dioHelper.get(endPoint: EndPoints.homeStore);

      final list =
          (response.data as List)
              .map((e) => HomeStoreModel.fromJson(e))
              .toList();
      return list;
    } on DioException catch (dioError) {
      logAndThrow(dioError.message.toString());

      throw failureFromDioError(dioError);
    } catch (e) {
      logAndThrow(e.toString());
      throw UnexpectedFailure("Unexpected error");
    }
  }
}
