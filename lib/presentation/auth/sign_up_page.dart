import 'package:flutter/material.dart';
import 'package:kitchen_confidant/presentation/components/sign_up_form.dart';
import 'package:kitchen_confidant/presentation/components/sign_up_page_header.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SignUpPageHeader(),
                SizedBox(height: AppDefaults.padding),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
