import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:surya_travel/pages/sign_in_page.dart';
import 'package:surya_travel/pages/sign_up_page.dart';
import 'package:surya_travel/providers/custom_auth.dart';
import 'providers/custom_auth.dart';
import 'package:sp_util/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CustomAuth(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SpUtil.getBool('isLogin')! ? MainPage() : SignInPage(),
      ),
    );
  }
}
