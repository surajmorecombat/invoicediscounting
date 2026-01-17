import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_text_theme.dart';
import 'package:invoicediscounting/src/router/approuter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://c6b4b3735c2a43cf358faf6eb8cc739f@o4510720145031168.ingest.us.sentry.io/4510724464902144';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
       options.debug = true;
    },
    appRunner: () => runApp(SentryWidget(child: MyApp(appRouter: AppRouter()))),
  );
  // TODO: Remove this line after sending the first sample event to sentry.
  // await Sentry.captureException(Exception('This is a sample exception.'));
  
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  const MyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constratints) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'invoicediscounting',
          theme: ThemeData(
            useMaterial3: false,

            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ).copyWith(textTheme: AppTextTheme.textTheme(context)),
          initialRoute: '/splashScreen',
          navigatorKey: MyApp.navigatorKey,
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      },
    );
  }
}
