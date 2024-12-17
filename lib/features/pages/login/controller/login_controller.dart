import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/routers/app_route.dart';
import '../provider/login_provider.dart';

final loginControllerProvider = Provider((ref) => LoginController(ref));

class LoginController {
  final Ref ref;

  LoginController(this.ref);

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geçerli bir e-mail adresi giriniz.')),
      );
      return;
    }

    if (!_isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Şifre 6-20 karakter uzunluğunda ve alfanumerik olmalıdır.'),
        ),
      );
      return;
    }

    try {
      final loginToken = await ref.read(
        loginProvider({'email': email, 'password': password}).future,
      );
      if (ref.watch(rememberMeProvider)) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', loginToken.actionLogin!.token!);
      }

      context.router.push(HomeRoute());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarısız: $e')),
      );
    }
  }
}
