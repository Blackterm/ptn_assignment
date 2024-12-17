import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/pages/category/screen/category_screen.dart';
import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/routers/app_route.dart';
import '../../../../shared/constants/constants.dart';
import '../../../../shared/data/models/categories.dart';
import '../provider/home_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryProvider);
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    width: screenWidth * 0.15,
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
                height: screenHeight * 0.04,
                width: screenWidth,
                child: categoriesAsync.when(
                  data: (categories) {
                    final modifiedCategories = [
                      Category(id: 0, name: "All"),
                      ...categories.category!,
                    ];
                    return ListView.builder(
                      itemCount: modifiedCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(selectedCategoryIdProvider.notifier)
                                  .state = modifiedCategories[index].id!;
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: selectedCategoryId ==
                                        modifiedCategories[index].id
                                    ? AppColors.backgroundPrimaryDark
                                    : AppColors.backgroundPrimaryLight,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                modifiedCategories[index].name!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedCategoryId ==
                                          modifiedCategories[index].id
                                      ? AppColors.white
                                      : AppColors.backgroundPrimaryDark,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Hata: $err')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (query) {
                  ref.read(searchQueryProvider.notifier).state = query;
                },
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundPrimaryLight,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ),
            Flexible(
              child: categoriesAsync.when(
                data: (categories) {
                  if (selectedCategoryId == 0) {
                    return ListView.builder(
                      itemCount: categories.category!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final category = categories.category![index];
                        return CategoryBookSection(category: category);
                      },
                    );
                  } else {
                    final selectedCategory = categories.category!.firstWhere(
                      (category) => category.id == selectedCategoryId,
                    );
                    return CategoryBookSection(category: selectedCategory);
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Hata: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryBookSection extends ConsumerWidget {
  final Category category;

  const CategoryBookSection({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    final searchQuery = ref.watch(searchQueryProvider);
    final booksAsync = ref.watch(bookProvider(category.id.toString()));

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
                  category.name ?? '',
                  style: AppTextStyles.bodyLg.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.router.push(
                      CategoryRoute(category: category),
                    );
                  },
                  child: Text(
                    'View All',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.buttonPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          booksAsync.when(
            data: (books) {
              final filteredBooks = books.product!
                  .where((book) => book.name!
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();

              if (filteredBooks.isEmpty) {
                return const Text('Bu kategoride kitap bulunmuyor.');
              }

              return SizedBox(
                height: h * 0.2,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];

                    return InkWell(
                      child: _BookWidget(
                        product: book,
                      ),
                      onTap: () {
                        context.router.push(BookDetailRoute(book: book));
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) {
              return Center(
                child: Text('Bir hata oluştu: $err'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BookWidget extends ConsumerWidget {
  final Product product;

  const _BookWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookImageAsync = ref.watch(imageProvider(product.slug!));
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.18,
      width: w * 0.65,
      margin: const EdgeInsets.only(
        right: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimaryLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          bookImageAsync.when(
            data: (image) {
              return Image.network(
                height: h * 0.2,
                image.actionProductImage!.url!,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      height: h * 0.3,
                      width: w * 0.3,
                      AppENV.placeHolder,
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) {
              return Center(
                child: Text('Bir hata oluştu: $err'),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: w * 0.32,
                  child: Text(
                    product.name!,
                    style: AppTextStyles.bodyLg.copyWith(
                      color: AppColors.black,
                      fontSize: 17,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: w * 0.32,
                  child: Text(
                    product.author!,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                Spacer(),
                Text(
                  '${product.price!} \$',
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
