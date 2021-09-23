import 'package:auto_route/annotations.dart';
import 'package:todoappv0/4_presentation/home/home_page.dart';
import 'package:todoappv0/4_presentation/signup/signup_page.dart';
import 'package:todoappv0/4_presentation/splash/splash_page.dart';
import 'package:todoappv0/4_presentation/todo_detail/todo_detail.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignUpPage, initial: false),
    AutoRoute(page: HomePage, initial: false),
    AutoRoute(page: TodoDetail, initial: false, fullscreenDialog: true),
  ],
)
class $AppRouter {}
