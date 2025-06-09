import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // لإستخدام debugPrint
import 'package:injectable/injectable.dart';

import '../../../../core/networke/network_exception.dart';
import '../../domain/entity/sign_up_parameters.dart';
import '../../domain/entity/user_sign_up_entity.dart';
import '../../domain/repository/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required SignUpParameters params,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final user = userCredential.user;
      if (user == null) {
        return Left(UnexpectedFailure('User is null after sign up.'));
      }

      await user.sendEmailVerification();

      final uid = user.uid;

      await firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': params.name,
        'email': params.email,
        'phone': params.phone,
      });

      return Right(
        UserEntity(
          uid: uid,
          name: params.name,
          email: params.email,
          phone: params.phone,
        ),
      );
    } on FirebaseAuthException catch (e) {

      debugPrint('FirebaseAuthException: ${e.message}');
      return Left(UnexpectedFailure(e.code ));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(UnexpectedFailure(e.toString()));
    }

  }

}
