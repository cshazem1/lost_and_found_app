import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/enum_info.dart';
import '../../../../core/helpers/validation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../generated/l10n.dart';
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

  @override
  void initState() {
    autovalidateMode = AutovalidateMode.disabled;
    super.initState();
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

            GestureDetector(
              onTap: () {
                autovalidateMode = AutovalidateMode.always;
                setState(() {});
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
            ),
          ],
        ),
      ),
    );
  }
}
