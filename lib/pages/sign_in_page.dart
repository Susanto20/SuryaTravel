import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import 'package:surya_travel/models/login_model.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:surya_travel/pages/sign_up_page.dart';
import 'package:surya_travel/services/service_api.dart';
import 'package:surya_travel/theme.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Surya Travel',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: warnaBiru,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 220,
              width: 430,
              child: Image.asset(
                'assets/images/travel.png',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              height: 40,
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                color: warnaAbu,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: textAbuStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'E-mail Address',
                      hintStyle: textAbuStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              height: 40,
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                color: warnaAbu,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: textAbuStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Password',
                      hintStyle: textAbuStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: TextButton(
                  onPressed: () {
                    _doLogin();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: warnaBiru,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belum punya akun ? ',
                  style: textAbuStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Klik Sign Up',
                    style: textAbuStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _doLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Alert(
      //         context: context,
      //         title: 'Data Tidak Boleh Kosong',
      //         type: AlertType.error)
      //     .show();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Data Tidak Boleh Kosong",
                style: warnaHitamStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Oke',
                    style: warnaHitamStyle,
                  ),
                ),
              ],
            );
          });
      return;
    }

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
      max: 1,
      msg: 'Loading',
      backgroundColor: warnaPutih,
      msgColor: warnaHitam,
      progressValueColor: warnaBiru,
    );
    final response = await http.post(
      Uri.parse(ServiceApi().getUrl + 'login'),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    progressDialog.close();
    if (response.statusCode == 200) {
      final loginModel = loginModelFromJson(response.body);
      // print(loginModol.data.token);
      var body = response.body;
      // print('oke------------------');
      // print(jsonDecode(response.body)['data']['user']['name']);
      print(jsonDecode(response.body)['data']['token']);
      print(jsonDecode(response.body)['data']['user']['id']);
      var token = loginModel.data?.token;
      var id = loginModel.data?.user.id;
      SpUtil.putString('token', token!);
      SpUtil.putString('id', id.toString());
      SpUtil.putBool('isLogin', true);
      SpUtil.putString('name', loginModel.data!.user.name!);
      SpUtil.putString('nomor_hp', loginModel.data!.user.nomor_hp!);
      SpUtil.putString('id', loginModel.data!.user.id.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainPage();
          },
        ),
      );
      // Alert(context: context, title: 'Login Berhasil', type: AlertType.success)
      //     .show();
    } else {
      // Alert(context: context, title: 'Login Gagal', type: AlertType.error)
      //     .show();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Login Gagal",
                style: warnaHitamStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Oke',
                    style: warnaHitamStyle,
                  ),
                ),
              ],
            );
          });
    }
  }
}
