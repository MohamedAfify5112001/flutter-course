import 'package:bloc/bloc.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/layout/shop_app/shop_home_screen/shop_layput_screen.dart';
import 'package:course_flutter/modules/shop_app/login_screen/login_screen.dart';
import 'package:course_flutter/modules/social_app/intial_screen_social/intial_screen_social.dart';
import 'package:course_flutter/shared/components/constants.dart';
import 'package:course_flutter/shared/cubit/cubit.dart';
import 'package:course_flutter/shared/cubit/states.dart';
import 'package:course_flutter/shared/cubit_observer/cubit_observer.dart';
import 'package:course_flutter/shared/network/local/cache_helper.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:course_flutter/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/news_app_by_api/cubit/cubit.dart';
import 'modules/shop_app/on_boarding_screen/boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.initDio();
  await CacheHelper.initSharedPreferences();
  bool isDark = CacheHelper.get(key: 'isDark');
  bool onBoarding = CacheHelper.get(key: "onBoarding");
  token = CacheHelper.get(key: 'token');
  Widget startWidget = BoardingScreen();

  if (onBoarding != null) {
    if (token != null) {
      startWidget = ShopLayout();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = BoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  final Widget startWidget;

  MyApp({required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsAppCubit()
              ..getBusinessData()
              ..getSportsData()
              ..getScienceData()),
        BlocProvider(
            create: (context) => AppCubit()..changeMode(fromShared: isDark)),
        BlocProvider(
            create: (context) => ShopHomeCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: (cubit.isDark) ? ThemeMode.dark : ThemeMode.light,
              home: InitialScreenSocial(),
            );
          }),
    );
  }
}
