import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_travel/pages/edit_profile_page.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:surya_travel/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _nama = "No Name";
  var _nomor = "No Number";
  var _alamat = "No Adress";

  _muatUpdate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _nama = (pref.getString('upNama') ?? '');
      _nomor = (pref.getString('upNo') ?? '');
      _alamat = (pref.getString('upAlamat') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _muatUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: warnaAbu,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: warnaBiru,
          title: Text(
            'Profile',
            style: warnaPutihStyle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfilePage();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: ListView(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                        color: warnaPutih, shape: CircleBorder()),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _nama,
                          style: warnaHitamStyle,
                        ),
                        Text(
                          _nomor,
                          style: warnaHitamStyle,
                        ),
                        Text(
                          _alamat,
                          style: warnaHitamStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ]));
  }
}
