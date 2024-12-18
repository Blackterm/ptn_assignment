import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/constants.dart';
import '../../../../shared/routers/app_route.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/aut_field.dart';
import '../controller/login_controller.dart';
import '../provider/login_provider.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;

    final loginController = ref.read(loginControllerProvider);
    final rememberMe = ref.watch(rememberMeProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              SizedBox(height: h * 0.09),
              Text(
                'welcome_back'.tr(),
                style: AppTextStyles.h4.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Text('login_account'.tr(), style: AppTextStyles.h3),
              SizedBox(height: h * 0.09),
              AuthField(
                fieldName: 'e-mail'.tr(),
                controller: _emailController,
                hintText: 'john@mail.com',
              ),
              const SizedBox(height: 10),
              AuthField(
                fieldName: 'password'.tr(),
                controller: _passwordController,
                hintText: '* * * * * *',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          ref.read(rememberMeProvider.notifier).state =
                              value ?? false;
                        },
                      ),
                      Text(
                        'remember_me'.tr(),
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.backgroundPrimaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      context.router.push(RegisterRoute());
                    },
                    child: Text(
                      'register'.tr(),
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
                title: 'login'.tr(),
                onTap: () {
                  loginController.login(
                    context,
                    _emailController.text,
                    _passwordController.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
