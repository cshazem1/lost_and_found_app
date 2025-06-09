import 'package:dartz/dartz.dart';

import '../../../../core/networke/network_exception.dart';
import '../entity/sign_up_parameters.dart';
import '../entity/user_sign_up_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp({
required SignUpParameters params
  });
}
