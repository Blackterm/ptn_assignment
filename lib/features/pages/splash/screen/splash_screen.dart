import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/constants.dart';
import '../../../../shared/routers/app_route.dart';
import '../../../widgets/custom_button.dart';
import '../controller/splash_controller.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late SplashController splashController;

  @override
  void initState() {
    super.initState();
    splashController = SplashController(context);
    splashController.startSplashTimer();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.splashPrimaryDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              AppENV.logo,
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
                    splashController.skip();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
