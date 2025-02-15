import 'package:cricket_app/src/configs/application.dart';
import 'package:cricket_app/src/configs/router.dart';
import 'package:cricket_app/src/constants/color_constant.dart';
import 'package:cricket_app/src/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/common_blocs/auth/bloc.dart';
import 'presentation/common_blocs/common_bloc.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

NavigatorState? get navigator => _navigatorKey.currentState;
BuildContext? get navigatorContext => _navigatorKey.currentContext;

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final authInitDuration = 2900;

  void onNavigate(String route) {
    navigator!.pushNamedAndRemoveUntil(route, (route) => false);
  }
  @override
  void initState() {
    super.initState();
    /// Show splash screen for [3 seconds] and then initialize AuthBloc
    Future.delayed(Duration(milliseconds : authInitDuration), () {
      CommonBloc.authenticationBloc.add(CheckAuthEvent());
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: Application.title,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.SPLASH,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: COLOR_CONST.primaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              if (state.role ==  UserRole.operator.value) {
                onNavigate(AppRouter.CREATOR_HOME);
              } else {
                onNavigate(AppRouter.HOME);
              }
            } else if (state is AuthUnauthenticated) {
              onNavigate(AppRouter.LOGIN);
            } else if (state is AuthLoading){
            }
          },
          child: child,
        );
      },
    );
  }
}