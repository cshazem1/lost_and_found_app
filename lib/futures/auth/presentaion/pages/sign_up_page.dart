import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lost_and_found_app/core/enums/enum_info.dart';
import 'package:lost_and_found_app/core/helpers/validation.dart';
import 'package:lost_and_found_app/core/theme/app_colors.dart';
import 'package:lost_and_found_app/core/theme/text_style.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../widgets/sign_up_body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.signUp, style: AppTextStyles.bodyLarge),
      ),
      body: SignUpBody(),
    );
  }
}





