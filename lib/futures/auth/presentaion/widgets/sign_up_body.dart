import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lost_and_found_app/core/routing/app_router.dart';
import 'package:lost_and_found_app/futures/auth/data/repository/auth_repository_impl.dart';
import 'package:lost_and_found_app/futures/auth/domain/repository/auth_repository.dart';

import '../../../../core/enums/enum_info.dart';
import '../../../../core/helpers/validation.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entity/sign_up_parameters.dart';
import '../cubits/auth_cubit.dart';
import '../pages/sign_up_page.dart';
import 'custom_auth_text_field.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  AutovalidateMode? autovalidateMode;
  TextEditingController nameSignUpController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  TextEditingController confirmPasswordSignUpController =
      TextEditingController();

  Timer? _timer;
  bool _isEmailVerified = false;

  @override
  void initState() {
    autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    nameSignUpController.dispose();
    emailSignUpController.dispose();
    passwordSignUpController.dispose();
    confirmPasswordSignUpController.dispose();
    super.dispose();
  }

  void startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.reload();
        final isVerified = user.emailVerified;
        if (isVerified) {
          _timer?.cancel();
          setState(() {
            _isEmailVerified = true;
          });

          Navigator.of(context).pushReplacementNamed(AppRoutes.homeStore);
        }
      }
    });
  }

  void showVerificationDialog() {
    startEmailVerificationCheck();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.checkYourEmail),
          content: Text(S.current.verificationEmailSentMessage),
          actions: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            20.verticalSpace,
            Center(
              child: Text(
                S.current.letsGetStarted,
                style: AppTextStyles.displaySmall,
              ),
            ),
            20.verticalSpace,
            CustomAuthTextField(
              enumInfo: EnumInfo.name,
              controller: nameSignUpController,
              validation: Validation.validateName,
            ),
            20.verticalSpace,
            CustomAuthTextField(
              enumInfo: EnumInfo.email,
              controller: emailSignUpController,
              validation: Validation.validateEmail,
            ),
            20.verticalSpace,
            CustomAuthTextField(
              enumInfo: EnumInfo.password,
              controller: passwordSignUpController,
              validation: Validation.validatePassword,
            ),
            20.verticalSpace,
            CustomAuthTextField(
              enumInfo: EnumInfo.confirmPassword,
              validation:
                  (value) => Validation.validateConfirmPassword(
                    value,
                    passwordSignUpController.text,
                  ),
            ),
            20.verticalSpace,

            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  showVerificationDialog();
                }
                if (state is SignUpFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(getFirebaseAuthErrorMessage(state.error, context))));
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GestureDetector(
                  onTap: () {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                    if (Form.of(context)!.validate()) {
                      context.read<AuthCubit>().signUp(
                        signUpParameters: SignUpParameters(
                          name: nameSignUpController.text,
                          email: emailSignUpController.text,
                          password: passwordSignUpController.text,
                          phone: '',
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: AppColors.lightAppBarBackground,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        S.current.signUp,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  String getFirebaseAuthErrorMessage(String code, BuildContext context) {
    switch (code) {
      case 'email-already-in-use':
        return S.of(context).emailAlreadyInUse;
      case 'invalid-email':
        return S.of(context).invalidEmail;
      case 'weak-password':
        return S.of(context).weakPassword;
      case 'user-not-found':
        return S.of(context).userNotFound;
      case 'wrong-password':
        return S.of(context).wrongPassword;
      default:
        return S.of(context).unexpectedError;
    }
  }

}
