import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lost_and_found_app/core/di/service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
