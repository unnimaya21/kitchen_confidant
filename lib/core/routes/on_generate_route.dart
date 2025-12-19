import 'package:flutter/cupertino.dart';
import 'package:kitchen_confidant/core/routes/app_routes.dart';
import 'package:kitchen_confidant/core/routes/unknown_page.dart';
import 'package:kitchen_confidant/presentation/auth/forget_password_page.dart';
import 'package:kitchen_confidant/presentation/auth/intro_login_page.dart'
    show IntroLoginPage;
import 'package:kitchen_confidant/presentation/auth/login_page.dart';
import 'package:kitchen_confidant/presentation/auth/password_reset_page.dart';
import 'package:kitchen_confidant/presentation/auth/sign_up_page.dart';
import 'package:kitchen_confidant/presentation/pages/entrypoint/entrypoint_ui.dart';
import 'package:kitchen_confidant/presentation/pages/profile/profile_screen.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.introLogin:
        return CupertinoPageRoute(builder: (_) => const IntroLoginPage());

      // case AppRoutes.onboarding:
      //   return CupertinoPageRoute(builder: (_) => const OnboardingPage());

      case AppRoutes.entryPoint:
        return CupertinoPageRoute(builder: (_) => const EntryPointUI());

      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.signup:
        return CupertinoPageRoute(builder: (_) => const SignUpPage());

      // case AppRoutes.numberVerification:
      //   return CupertinoPageRoute(
      //       builder: (_) => const NumberVerificationPage());

      case AppRoutes.forgotPassword:
        return CupertinoPageRoute(builder: (_) => const ForgetPasswordPage());

      case AppRoutes.passwordReset:
        return CupertinoPageRoute(builder: (_) => const PasswordResetPage());

      case AppRoutes.profile:
        return CupertinoPageRoute(builder: (_) => const ProfileScreen());

      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => const UnknownPage());
}
