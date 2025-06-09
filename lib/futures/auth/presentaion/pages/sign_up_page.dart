import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found_app/core/theme/text_style.dart';
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





