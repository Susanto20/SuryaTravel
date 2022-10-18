import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:provider/provider.dart';
import '../providers/custom_auth.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _signupUser(
    SignupData data,
  ) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      // return 'null';
      Provider.of<CustomAuth>(context, listen: false)
          .signup(data.name!, data.password!);
      return null;
    });
  }

  Future<String> _authUserLogin(
    LoginData data,
  ) async {
    debugPrint('Login Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      // return 'null';
      Provider.of<CustomAuth>(context, listen: false)
          .login(data.name, data.password);
      return 'null';
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'null';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'SuryaTravel',
      logo: AssetImage('assets/images/travel.png'),
      onLogin: _authUserLogin,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
