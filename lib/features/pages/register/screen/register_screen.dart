import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/pages/register/controller/register_controller.dart';

import '../../../../shared/constants/constants.dart';
import '../../../../shared/routers/app_route.dart';
import '../../../widgets/aut_field.dart';
import '../../../widgets/custom_button.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;

    final registerController = ref.read(registerControllerProvider);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: padding.top),
              child: Center(
                child: Image.asset(
                  AppENV.logo,
                  width: w * 0.3,
                ),
              ),
            ),
            SizedBox(
              height: h * 0.09,
            ),
            Text(
              'Welcome',
              style: AppTextStyles.h4.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Register an account',
              style: AppTextStyles.h3,
            ),
            SizedBox(
              height: h * 0.09,
            ),
            AuthField(
              fieldName: 'Name',
              controller: _nameController,
              hintText: 'Jhon Doe',
            ),
            const SizedBox(
              height: 10,
            ),
            AuthField(
              fieldName: 'E-mail',
              controller: _emailController,
              hintText: 'john@mail.com',
            ),
            const SizedBox(
              height: 10,
            ),
            AuthField(
              fieldName: 'Password',
              controller: _passwordController,
              hintText: '* * * * * *',
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                InkWell(
                  onTap: () {
                    context.router.push(
                      LoginRoute(),
                    );
                  },
                  child: Text(
                    'Login',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.backgroundPrimaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              title: 'Register',
              onTap: () {
                registerController.register(
                  context,
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
