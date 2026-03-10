import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/app_router.dart';

import 'core/app_cubit/app_state.dart';
import 'core/helpers/dynamic_link_service.dart';
import 'core/theme_manager.dart';
import 'core/di/di.dart';
import 'features/main_screen/controller/main_screen_cubit.dart'
    show MainScreenCubit;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  static late bool isDark;
  static late BuildContext appContext;
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   DynamicLinkService deepLink = DynamicLinkService();
  //   deepLink.initDeepLinking();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AppCubit>()),
        BlocProvider(create: (context) => getIt<MainScreenCubit>()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, local) {
          MyApp.appContext = context;
          var cubit = getIt<AppCubit>();
          MyApp.isDark = cubit.isDark;
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) {
              MyApp.appContext = context;
              return "HR Management".tr();
            },
            theme: lightTheme(),
            // darkTheme: darkTheme(),
            // themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            locale: cubit.locale,
            localizationsDelegates: [
              ...context.localizationDelegates,

              CountryLocalizations.delegate,
            ],
            supportedLocales: context.supportedLocales,
            onGenerateRoute: AppRouter.generatedRoute,
            initialRoute: Routes.mainScreen,
          );
        },
      ),
    );
  }
}
