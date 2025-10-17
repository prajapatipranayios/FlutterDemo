import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/initial/bindings/initial_binding.dart';
import '../modules/initial/views/initial_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/player_card/bindings/player_card_binding.dart';
import '../modules/player_card/views/player_card_view.dart';
import '../modules/search_player/bindings/search_player_binding.dart';
import '../modules/search_player/views/search_player_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/team_card/bindings/team_card_binding.dart';
import '../modules/team_card/views/team_card_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const MYROOT = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER_CARD,
      page: () => const PlayerCardView(),
      binding: PlayerCardBinding(),
    ),
    GetPage(
      name: _Paths.TEAM_CARD,
      page: () => const TeamCardView(),
      binding: TeamCardBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PLAYER,
      page: () => const SearchPlayerView(),
      binding: SearchPlayerBinding(),
    ),
  ];
}
