import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/routers/app_route.dart';

class SplashController {
  final BuildContext context;
  SplashController(this.context);
  Future<void> navigateBasedOnToken() async {
    if (!context.mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');

    if (token != null && token.isNotEmpty) {
      context.router.pushAndPopUntil(
        HomeRoute(),
        predicate: (_) => false,
      );
    } else {
      context.router.pushAndPopUntil(
        LoginRoute(),
        predicate: (_) => false,
      );
    }
  }

  Future<void> startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    await navigateBasedOnToken();
  }

  void skip() async {
    await navigateBasedOnToken();
  }
}
