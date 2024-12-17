import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptn_assignment/features/pages/home/provider/home_provider.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
import 'package:ptn_assignment/shared/data/models/cover_image.dart';

void main() {
  group('Home Providers Test', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Category Provider returns data', () async {
      final result = await container.read(categoryProvider.future);

      expect(result, isA<Categories>());
    });

    test('Image Provider returns cover image', () async {
      const testFileName = 'test_image';
      final result = await container.read(imageProvider(testFileName).future);

      expect(result, isA<CoverImage>());
    });

    test('SelectedCategoryIdProvider default value is 0', () {
      final value = container.read(selectedCategoryIdProvider);
      expect(value, 0);
    });

    test('SearchQueryProvider updates correctly', () {
      container.read(searchQueryProvider.notifier).state = 'Flutter';
      final value = container.read(searchQueryProvider);
      expect(value, 'Flutter');
    });
  });
}
