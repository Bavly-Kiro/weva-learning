import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:weva/presentation/screens/Live.dart';
import 'back/checLogin.dart';
import 'firebase_options.dart';
import 'presentation/on_boarding/on_boarding_screen.dart';
import 'package:is_first_run/is_first_run.dart';

//Localizations.localeOf(context).toString()

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(OKToast(
      position: ToastPosition.bottom,
      child: EasyLocalization(
          supportedLocales: L10n.all,
          path:
              'assets/translations', // <-- change the path of the translation files
          fallbackLocale: L10n.all[0],
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    checkFirstTime();
  }

  void checkFirstTime() async {
    bool firstRun = await IsFirstRun.isFirstRun();

    if (firstRun) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const checkLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Intlak.......');
  }
}

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
  ];
}
