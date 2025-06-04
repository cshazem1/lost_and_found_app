import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/enums/enum_info.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../pages/sign_up_page.dart';

class CustomAuthTextField extends StatefulWidget {
  TextEditingController? controller;
  final String? Function(String?)? validation;
  final EnumInfo enumInfo;

  CustomAuthTextField({
    super.key,
    this.controller,
    required this.enumInfo,
    this.validation,
  });


  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  final FocusNode focusNode = FocusNode();
  bool isFocused = false;
  TextInputType? keyboardType;

  late final TextEditingController _controller;
  late TextFieldEntity textFieldEntity;
  bool isHiddenPassword=false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();

    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });

    textFieldEntity = getTextFieldEntity(widget.enumInfo);
switch (widget.enumInfo) {
  case EnumInfo.name:
    keyboardType = TextInputType.name;
    break;
  case EnumInfo.email:
    keyboardType = TextInputType.emailAddress;
    break;
  case EnumInfo.password:
    keyboardType = TextInputType.visiblePassword;
    isHiddenPassword = true;
    break;
  case EnumInfo.confirmPassword:
    keyboardType = TextInputType.visiblePassword;
    isHiddenPassword = true;
    break;
}

  }

  @override
  void dispose() {
    focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkGray.withOpacity(0.01),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        validator: widget.validation,
        obscureText: isHiddenPassword,
        focusNode: focusNode,
        cursorColor: AppColors.black,
        cursorErrorColor: AppColors.red,
        controller: _controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon:
          (widget.enumInfo == EnumInfo.confirmPassword ||
              widget.enumInfo == EnumInfo.password)
              ? GestureDetector(
            onTap: () {
              setState(() {
                isHiddenPassword = !isHiddenPassword;
              });
            },
            child: Icon(
              isHiddenPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.darkGray,
            ),
          )
              : null,
          prefixIcon: (!isFocused && _controller.text == '')
              ? null
              : SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: SvgPicture.asset(
                textFieldEntity.icon ?? '',
                color: AppColors.darkGray,
                width: 20,
                height: 20,
              ),
            ),
          ),
          border: OutlineInputBorder(
            gapPadding: 30,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: AppColors.skyBlue,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: AppColors.steelBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: AppColors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: AppColors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: AppColors.darkGray),
          ),
          hint: isFocused
              ? Text(
            textFieldEntity.hint ?? '',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkGray,
            ),
          )
              : null,
          label: Text(
            textFieldEntity.label ?? '',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkGray),
          ),
        ),
      ),
    );
  }

  TextFieldEntity getTextFieldEntity(EnumInfo enumInfo) {
    switch (enumInfo) {
      case EnumInfo.name:
        return TextFieldEntity(
          hint: S.current.enterYourName,
          label: S.current.name,
          icon: Assets.iconsNameIcon,
        );
      case EnumInfo.email:
        return TextFieldEntity(
          hint: S.current.enterYourEmail,
          label: S.current.email,
          icon: Assets.iconsEmailIcon,
        );
      case EnumInfo.password:
        return TextFieldEntity(
          hint: S.current.enterYourPassword,
          label: S.current.password,
          icon: Assets.iconsPassword,
        );
      case EnumInfo.confirmPassword:
        return TextFieldEntity(
          hint: S.current.enterYourConfirmPassword,
          label: S.current.confirmPassword,
          icon: Assets.iconsPassword,
        );
    }
  }
}
class TextFieldEntity {
  final String? hint;
  final String? label;
  final String? icon;
  TextFieldEntity({this.hint, this.label, this.icon});
}