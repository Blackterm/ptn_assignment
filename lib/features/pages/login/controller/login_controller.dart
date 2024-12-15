import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/routers/app_route.dart';
import '../provider/login_provider.dart';

final loginControllerProvider = Provider((ref) => LoginController(ref));

class LoginController {
  final Ref ref;

  LoginController(this.ref);

  // E-mail validasyon kontrolü
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  // Şifre validasyon kontrolü
  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    // E-mail ve şifre boş mu kontrolü
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    // E-mail validasyonu
    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geçerli bir e-mail adresi giriniz.')),
      );
      return;
    }

    // Şifre validasyonu
    if (!_isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Şifre 6-20 karakter uzunluğunda ve alfanumerik olmalıdır.'),
        ),
      );
      return;
    }

    // Giriş işlemi
    try {
      final loginToken = await ref.read(
        loginProvider({'email': email, 'password': password}).future,
      );

      // Giriş başarılı, ana sayfaya yönlendirme
      context.router.push(
        HomeRoute(),
      );
    } catch (e) {
      // Giriş başarısız, hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarısız: $e')),
      );
    }
  }
}
