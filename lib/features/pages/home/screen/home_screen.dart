import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/constants.dart';
import '../provider/home_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;

    final categoriesAsync = ref.watch(categoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppENV.logo,
                    width: w * 0.15,
                  ),
                  const Text(
                    'Catalog',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: h * 0.04,
                width: w,
                child: categoriesAsync.when(
                  data: (categories) => ListView.builder(
                    itemCount: categories.category!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundPrimaryLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            categories.category![index].name!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.backgroundPrimaryDark,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Hata: $err')),
                ),
              ),
            ),

            Expanded(
              child: categoriesAsync.when(
                data: (categories) => ListView.builder(
                  itemCount: categories.category!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categories.category![index].name!,
                                  style: AppTextStyles.bodyLg.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'View All',
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: AppColors.buttonPrimary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _BookWidget(),
                        ],
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Hata: $err')),
              ),
            ),

            // "Best Seller" Kartı Örneği
          ],
        ),
      ),
    );
  }
}

class _BookWidget extends StatelessWidget {
  const _BookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.18,
      width: w * 0.6,
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimaryLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Image.network(
              'https://s3.piton.com.tr/assignment/dune.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=P%21T10.MINIO%2F20241215%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241215T211148Z&X-Amz-Expires=600&X-Amz-SignedHeaders=host&X-Amz-Signature=20cf98ced614cf7f3e8557390bda903880e5a889f88b2ba3a02821d2d0be65af'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dune',
                  style: AppTextStyles.bodyLg.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Text(
                  'Frank Herbert',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                Text(
                  '87.75 TL',
                  style: AppTextStyles.bodyLg.copyWith(
                    color: AppColors.backgroundPrimaryDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
