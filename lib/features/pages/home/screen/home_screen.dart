import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/constants.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppENV.logo,
                    width: w * 0.15,
                  ),
                  const Text(
                    'Catalog',
                    style: AppTextStyles.h2,
                  ),
                ],
              ),
              Container(
                height: h * 0.04,
                width: w,
                child: ListView.builder(
                  itemCount: 50,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundPrimaryLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Adaptive Width $index",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColors.backgroundPrimaryDark,
                              fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
