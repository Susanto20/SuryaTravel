import 'package:flutter/material.dart';
import 'package:surya_travel/pages/sign_in_page.dart';
import 'package:surya_travel/theme.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    final response = await http.post(
      Uri.parse(
          'https://4f30-180-242-214-37.ap.ngrok.io/surya-travel/api/user/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'nomor_hp': nomor_hp,
      },
      // headers: {
      //   'Accept': 'application/json',
      // },
    );

    if (response.statusCode == 200) {
      // Alert(
      //         context: context,
      //         title: 'Data Berhasil Disimpan',
      //         type: AlertType.success)
      //     .show();
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
      // Alert(
      //         context: context,
      //         title: 'Data Gagal Disimpan',
      //         type: AlertType.error)
      //     .show();
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
