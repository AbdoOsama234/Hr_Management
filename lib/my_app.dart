import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_cubit/app_cubit.dart';
import 'package:hr_manegement/core/app_router.dart';

import 'core/app_cubit/app_state.dart';
import 'core/theme_manager.dart';
import 'core/di/di.dart';
import 'features/main_screen/controller/main_screen_cubit.dart'
    show MainCubit;
import 'features/profile/controller/profile_cubit.dart';

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
        BlocProvider(create: (context) => getIt<MainCubit>()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, local) {
          MyApp.appContext = context;
          var appCubit = context.read<AppCubit>();
          MyApp.isDark = appCubit.isDark;

          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) {
              MyApp.appContext = context;
              return "HR Management".tr();
            },
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: appCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            locale: context.locale,
            localizationsDelegates: [
              ...context.localizationDelegates,
              CountryLocalizations.delegate,
            ],
            supportedLocales: context.supportedLocales,
            onGenerateRoute: AppRouter.generatedRoute,
            initialRoute: Routes.splash,
            onGenerateInitialRoutes: (String initialRoute) {
              // Always start with only the splash route.
              // This prevents Flutter from splitting a deep link URI
              // (e.g. /Car/123) into sub-routes that trigger "no route".
              return [
                AppRouter.generatedRoute(
                  const RouteSettings(name: Routes.splash),
                ),
              ];
            },
          );
        },
      ),
    );
  }
}
