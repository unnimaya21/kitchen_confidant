import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitchen_confidant/core/constants/app_defaults.dart';
import 'package:kitchen_confidant/core/constants/app_icons.dart';
import 'package:kitchen_confidant/core/routes/app_routes.dart';
import 'package:kitchen_confidant/core/utils/validators.dart';
import 'package:kitchen_confidant/data/models/user_model.dart';
import 'package:kitchen_confidant/presentation/providers/auth_provider.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';

class SignUpForm extends ConsumerWidget {
  SignUpForm({super.key});

  final TextEditingController userName = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name"),
          const SizedBox(height: 8),
          TextFormField(
            validator: Validators.requiredWithFieldName('Name').call,
            controller: userName,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Email"),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: userEmail,
            validator: Validators.required.call,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Password"),
          const SizedBox(height: 8),
          TextFormField(
            validator: Validators.required.call,
            controller: userPassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.eye, width: 24),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDefaults.padding),
          SignUpButton(
            onPresssed: () async {
              User user = User(
                username: userName.text,
                email: userEmail.text,
                password: userPassword.text,
                id: '',
              );
              final result = await ref.read(signUpProvider(user).future);
              print('Signed up user: ${result.email}');
              if (result.email.isNotEmpty) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
              }
            },
          ),
          const AlreadyHaveAnAccount(),
          const SizedBox(height: AppDefaults.padding),
        ],
      ),
    );
  }
}
