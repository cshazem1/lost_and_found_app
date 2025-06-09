import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:lost_and_found_app/futures/auth/domain/entity/user_sign_up_entity.dart';
import 'package:lost_and_found_app/futures/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/sign_up_parameters.dart';

part 'auth_state.dart';
@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.signUpUseCase) : super(AuthInitial());
  SignUpUseCase signUpUseCase;

  Future<void> signUp({
   required SignUpParameters signUpParameters,
  }) async {
    emit(SignUpLoading());

  final result =    await signUpUseCase(
        signUpParameters,
      );

      result.fold(
        (failure) => emit(SignUpFailure(failure.message)),
        (user) => emit(SignUpSuccess()),
      );


  }


}
