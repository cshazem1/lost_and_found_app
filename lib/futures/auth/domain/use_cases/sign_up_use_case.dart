import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:lost_and_found_app/core/use_case/use_case.dart';
import 'package:lost_and_found_app/futures/auth/domain/entity/user_sign_up_entity.dart';

import '../../../../core/networke/network_exception.dart';
import '../entity/sign_up_parameters.dart';
import '../repository/auth_repository.dart';
@LazySingleton()
class SignUpUseCase extends UseCase<Future<Either<Failure, UserEntity>>, SignUpParameters> {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);
  @override
 Future< Either<Failure, UserEntity>> call(SignUpParameters params) {
    return authRepository.signUp(
      params: params,

    );
  }
}