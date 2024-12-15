import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/constants.dart';
import '../../../../shared/routers/app_route.dart';
import '../../../widgets/custom_button.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: AppColors.splashPrimaryDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(''),
          const Spacer(),
          Center(
            child: Image.asset(
              "assets/Logo.png",
            ),
          ),
          const Spacer(),
          Container(
              margin: EdgeInsets.only(bottom: padding.bottom + 5),
              child: Column(
                children: [
                  CustomButton(
                    title: 'Login',
                    onTap: () {
                      context.router.pushAndPopUntil(
                        LoginRoute(),
                        predicate: (_) => false,
                      );
                    },
                  ),
                  InkWell(
                    child: SizedBox(
                      height: h * 0.06,
                      width: w,
                      child: Center(
                        child: Text(
                          'Skip',
                          style: AppTextStyles.bodyLg.copyWith(
                            color: AppColors.backgroundPrimaryDark,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      context.router.pushAndPopUntil(
                        LoginRoute(),
                        predicate: (_) => false,
                      );
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
