import 'package:cricket_app/firebase_options.dart';
import 'package:cricket_app/src/app_view.dart';
import 'package:cricket_app/src/configs/size_config.dart';
import 'package:cricket_app/src/presentation/common_blocs/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'presentation/common_blocs/common_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return const AppView();
            },
          );
        },
      ),
    );
  }
}
