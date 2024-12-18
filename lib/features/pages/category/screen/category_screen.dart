import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/constants.dart';
import '../../../../shared/data/models/books.dart';
import '../../../../shared/data/models/categories.dart';
import '../../../../shared/routers/app_route.dart';
import '../../../widgets/custom_appbar.dart';
import '../provider/category_provider.dart';

@RoutePage()
class CategoryScreen extends ConsumerStatefulWidget {
  final Category category;

  CategoryScreen({Key? key, required this.category}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchProvider);
    final booksAsync = ref.watch(bookProvider(widget.category.id.toString()));

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomAppbar(title: widget.category.name!),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (query) {
                  ref.read(searchProvider.notifier).state = query;
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
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: booksAsync.when(
                data: (books) {
                  final filteredBooks = books.product!
                      .where((book) => book.name!
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();

                  if (filteredBooks.isEmpty) {
                    return const Center(child: Text('Kitap Bulunamadı.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return InkWell(
                        child: _BookWidget(
                          product: book,
                        ),
                        onTap: () {
                          context.router.push(BookDetailRoute(
                              book: book,
                              categoryId: widget.category.id!.toString()));
                        },
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
            ),
          ],
        ),
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
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimaryLight,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bookImageAsync.when(
            data: (image) {
              return Center(
                child: Image.network(
                  image.actionProductImage!.url!,
                  height: h * 0.25,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        height: h * 0.25,
                        width: w * 0.3,
                        AppENV.placeHolder,
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (err, stack) {
              return Container(
                height: h * 0.18,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(child: Icon(Icons.error, size: 40)),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Container(
                      width: w * 0.2,
                      child: Text(
                        product.author ?? '',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${product.price!} \$',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundPrimaryDark,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
