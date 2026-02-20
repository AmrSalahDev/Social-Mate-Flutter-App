import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/ui/system/system_ui_wrapper.dart';
import 'package:social_mate_app/core/di/di.dart';
import 'package:social_mate_app/core/l10n/generated/l10n.dart';
import 'package:social_mate_app/core/routes/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_mate_app/core/theme/light_text_theme.dart';
import 'package:social_mate_app/core/theme/light_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_mate_app/global/bloc/app_flow_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  configureDependencies();

  Bloc.observer = TalkerBlocObserver();

  // load environment variables
  await dotenv.load(fileName: ".env");

  // initialize supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    BlocProvider.value(
      value: getIt<AppFlowBloc>(),
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const SocialMateApp(),
      ),
    ),
  );
}

class SocialMateApp extends StatelessWidget {
  const SocialMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appFlowBloc = context.read<AppFlowBloc>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Social Mate',
        debugShowCheckedModeBanner: false,

        locale: DevicePreview.locale(context),

        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);

          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(
                mediaQuery.textScaler.scale(1).clamp(1.0, 1.3),
              ),
            ),
            child: DevicePreview.appBuilder(
              context,
              SystemUIWrapper(
                statusBarColor: Theme.of(context).colorScheme.surface,
                statusBarIconBrightness: Brightness.dark,
                navigationBarColor: Theme.of(context).colorScheme.surface,
                navigationBarIconBrightness: Brightness.dark,
                child: child!,
              ),
            ),
          );
        },

        routerConfig: AppRouter.router(appFlowBloc: appFlowBloc),
        theme: createLightTheme(lightTextTheme()),
        themeMode: ThemeMode.light,

        localizationsDelegates: const [
          AppStrings.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppStrings.delegate.supportedLocales,
      ),
    );
  }
}
