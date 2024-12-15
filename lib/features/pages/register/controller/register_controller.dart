import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/pages/register/provider/register_provider.dart';
import '../../../../shared/routers/app_route.dart';

final registerControllerProvider = Provider((ref) => RegisterController(ref));

class RegisterController {
  final Ref ref;

  RegisterController(this.ref);

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> register(
      BuildContext context, String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
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
      final token = await ref.read(
        registerProvider({'name': name, 'email': email, 'password': password})
            .future,
      );

      context.router.push(
        HomeRoute(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarısız: $e')),
      );
    }
  }
}
