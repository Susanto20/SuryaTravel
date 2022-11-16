import 'package:flutter/material.dart';
import 'package:surya_travel/pages/sign_in_page.dart';
import 'package:surya_travel/services/service_api.dart';
import 'package:surya_travel/theme.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaPutih,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 200,
                width: 300,
                child: Image.asset(
                  'assets/images/travel.png',
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                    textCapitalization: TextCapitalization.words,
                    controller: nameController,
                    style: textAbuStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Name',
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
              height: 15,
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
                    textCapitalization: TextCapitalization.words,
                    controller: nomorHpController,
                    style: textAbuStyle,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Nomor Hp',
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
              height: 15,
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
              height: 15,
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
              height: 10,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: TextButton(
                  onPressed: () {
                    _doDaftar();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: warnaBiru,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    'Sign Up',
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
                  'Sudah punya akun ? ',
                  style: textAbuStyle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignInPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Klik Sign In',
                    style: textAbuStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _doDaftar() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String nomor_hp = nomorHpController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || nomor_hp.isEmpty) {
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
      Uri.parse(ServiceApi().getUrl + 'user/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'nomor_hp': nomor_hp,
      },
    );

    progressDialog.close();
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Data Berhasil Disimpan",
                style: warnaHitamStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignInPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Oke',
                    style: warnaHitamStyle,
                  ),
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Data Gagal Disimpan",
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
