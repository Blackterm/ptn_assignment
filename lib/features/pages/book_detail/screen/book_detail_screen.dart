import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/widgets/custom_appbar.dart';
import 'package:ptn_assignment/main.dart';
import 'package:ptn_assignment/shared/data/models/books.dart';
import '../../../../shared/constants/constants.dart';
import '../../home/provider/home_provider.dart';
import '../provider/book_detail_provider.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class BookDetailScreen extends ConsumerWidget {
  final Product? book;
  final String categoryId;

  const BookDetailScreen({
    Key? key,
    required this.categoryId,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookImageAsync = ref.watch(imageProvider(book!.slug!));
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppbar(
                title: 'book_details'.tr(),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppENV.unlike,
                    color: Colors.white,
                  ),
                  bookImageAsync.when(
                    data: (image) {
                      return Image.network(
                        height: h * 0.3,
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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) {
                      return Center(
                        child: Text('error_message'
                            .tr(namedArgs: {'error': err.toString()})),
                      );
                    },
                  ),
                  LikeWidget(
                    categoryId: categoryId,
                    imageId: book!.id.toString(),
                    isLiked: book!.likesAggregate!.aggregate!.count != 0
                        ? true
                        : false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                book!.name!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                book!.author!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'summary'.tr(),
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: h * 0.25,
                child: SingleChildScrollView(
                  child: Text(
                    book!.description!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: h * 0.06,
                width: w,
                decoration: BoxDecoration(
                  color: AppColors.buttonPrimary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        '${book!.price} \$',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'buy_now'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LikeWidget extends ConsumerStatefulWidget {
  final String imageId;
  final bool isLiked;
  final String categoryId;

  const LikeWidget({
    Key? key,
    required this.categoryId,
    required this.imageId,
    required this.isLiked,
  }) : super(key: key);

  @override
  ConsumerState<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends ConsumerState<LikeWidget> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();

    isLiked = widget.isLiked;
  }

  Future<void> toggleLike() async {
    try {
      if (isLiked) {
        await ref.read(unLikeImageProvider(widget.imageId).future);
      } else {
        await ref.read(likeImageProvider(widget.imageId).future);
      }

      setState(() {
        isLiked = !isLiked;
      });

      ref.read(forceRefreshProvider.notifier).state = true;
      ref.invalidate(bookHomeProvider(widget.categoryId));
    } catch (error) {
      print('Hata: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleLike,
      child: Image.asset(
        isLiked ? AppENV.like : AppENV.unlike,
      ),
    );
  }
}
