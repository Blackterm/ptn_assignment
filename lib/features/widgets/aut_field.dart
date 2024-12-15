import 'package:flutter/material.dart';
import '../../shared/constants/constants.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.fieldName,
  }) : super(key: key);

  final String fieldName;
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          key: key,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.backgroundPrimaryLight,
            hintText: hintText,
            hintStyle: AppTextStyles.bodyLg.copyWith(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4), // Yuvarlatılmış kenarlar
              borderSide: BorderSide.none, // Varsayılan border yok
            ),
          ),
        ),
      ],
    );
  }
}
