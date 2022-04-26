import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:hope_nest/util/init/route_generator.dart';
import 'package:hope_nest/util/init/service_locator.dart';
import 'package:hope_nest/view_models/advert_vm.dart';
import 'package:hope_nest/view_models/app_user_vm.dart';
import 'package:hope_nest/view_models/report_vm.dart';
import 'package:hope_nest/views/root.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  initializeLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppUserVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdvertVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportVM(),
        ),
      ],
      child: MaterialApp(
        title: 'Hope Nest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Palette.MAIN_COLOR,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/login/background.jpg"),
                    fit: BoxFit.cover)),
            child: const RootPage()),
        onGenerateRoute: RouteGenerator.initializeRoute,
        onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
          builder: (context) => const RootPage(),
        ), // if there is any problem with navigation returns to the Root
      ),
    );
  }
}
