import 'package:auto_route/auto_route.dart';
import '../../features/pages/book_detail/screen/book_detail_screen.dart';
import '../../features/pages/category/screen/category_screen.dart';
import '../../features/pages/home/screen/home_screen.dart';
import '../../features/pages/login/screen/login_screen.dart';
import '../../features/pages/register/screen/register_screen.dart';
import '../../features/pages/splash/screen/splash_screen.dart';
part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: BookDetailRoute.page),
      ];
}
