import 'package:cricket_app/src/data/models/player_model.dart';
import 'package:cricket_app/src/presentation/screens/creator_home/creator_home_screen.dart';
import 'package:cricket_app/src/presentation/screens/edit_player_details/edit_player_details_screen.dart';
import 'package:cricket_app/src/presentation/screens/home/home_screen.dart';
import 'package:cricket_app/src/presentation/screens/login/login_screen.dart';
import 'package:cricket_app/src/presentation/screens/player_details/player_detail_screen.dart';
import 'package:cricket_app/src/presentation/screens/search_players/search_player_screen.dart';
import 'package:cricket_app/src/presentation/screens/signup/signup_screen.dart';
import 'package:cricket_app/src/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String INITIALIZE_INFO = '/initialize_info';
  static const String SIGNUP = '/signup';
  static const String FORGOT_PASSWORD = '/forgot_password';
  static const String HOME = '/home';
  static const String CREATOR_HOME = '/creator_home';
  static const String PLAYER_DETAILS_SCREEN = '/playerDetails';
  static const String SEARCH_SCREEN = '/searchScreen';
  static const String EDIT_PLAYER_DETAILS_SCREEN = '/editPlayerDetails';
  static const String DETAIL_IMAGE = '/detail_image';
  static const String FEEDBACK = '/feedback';
  static const String CART = '/cart';
  static const String MY_ORDERS = '/my_orders';
  static const String DETAIL_ORDER = '/detail_order';
  static const String DELIVERY_ADDRESS = '/delivery_address';
  static const String MAP = '/map';
  static const String CATEGORIES = '/categories';
  static const String SETTING = '/setting';
  static const String MESSAGES = '/messages';
  static const String SEARCH = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case LOGIN:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case SIGNUP:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case PLAYER_DETAILS_SCREEN:
        final playerDetails = settings.arguments as PlayerDetailModel;
        return MaterialPageRoute(
          builder: (_) => PlayerDetailScreen(player: playerDetails,),
        );
      case SEARCH_SCREEN:
        return MaterialPageRoute(
          builder: (_) => const SearchPlayerScreen(),
        );
      case HOME:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case CREATOR_HOME:
        return MaterialPageRoute(
          builder: (_) => const CreatorHomeScreen(),
        );
      case EDIT_PLAYER_DETAILS_SCREEN:
        final playerDetails = settings.arguments as PlayerDetailModel;
        return MaterialPageRoute(
          builder: (_) => EditPlayerDetailsScreen(player: playerDetails),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  ///Singleton factory
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
