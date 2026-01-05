import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_text_theme.dart';
import 'package:invoicediscounting/src/router/approuter.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
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
