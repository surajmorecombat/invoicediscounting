import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_text_theme.dart';
import 'package:invoicediscounting/src/router/approuter.dart';
import 'package:invoicediscounting/src/services/app_lock_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://c6b4b3735c2a43cf358faf6eb8cc739f@o4510720145031168.ingest.us.sentry.io/4510724464902144';

    options.tracesSampleRate = 1.0;

    options.profilesSampleRate = 1.0;
    options.debug = true;
  }, appRunner: () => runApp(SentryWidget(child: MyApp(appRouter: AppRouter()))));
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({super.key, required this.appRouter});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AppLockService _appLockService = AppLockService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final context = MyApp.navigatorKey.currentContext;
    if (context == null) return;

    if (state == AppLifecycleState.resumed) {
      _appLockService.handleResume(context);
    } else if (state == AppLifecycleState.paused) {
      _appLockService.markActive();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'invoicediscounting',
      navigatorKey: MyApp.navigatorKey,
      initialRoute: '/splashScreen',
      onGenerateRoute: widget.appRouter.onGenerateRoute,
      theme: ThemeData(
        useMaterial3: false,
      ).copyWith(textTheme: AppTextTheme.textTheme(context)),
    );
  }
}


/*
class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  const MyApp({super.key, required this.appRouter});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constratints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'invoicediscounting',
          theme: ThemeData(
            useMaterial3: false,

        
          ).copyWith(textTheme: AppTextTheme.textTheme(context)),
          initialRoute: '/splashScreen',
          navigatorKey: MyApp.navigatorKey,
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      },
    );
  }
}
*/