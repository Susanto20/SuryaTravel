import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:surya_travel/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  var _nama = "No Name";
  var _nomor = "No Number";
  var _alamat = "No Adress";

  _updateNama(updateNama) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('upNama', updateNama);
    });
  }

  _updateNomor(updateNo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('upNo', updateNo);
    });
  }

  _updateAlamat(updateAlamat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString('upAlamat', updateAlamat);
    });
  }

  _muatUpdate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _nama = (pref.getString('upNama') ?? '');
      _nomor = (pref.getString('upNo') ?? '');
      _alamat = (pref.getString('upAlamat') ?? '');
    });
  }

  Future<void> showSuccesDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
              width: 350,
              child: AlertDialog(
                backgroundColor: warnaPutih,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Data Berhasil Disimpan',
                        style: warnaBiruStyle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MainPage();
                              },
                            ),
                          );
                          _updateNama(namaController.text);
                          _muatUpdate();
                        },
                        child: Container(
                          height: 70,
                          child: Image.asset(
                            'assets/images/checklist.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
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
            'Edit Profile',
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
        ),
        body: ListView(children: [
          Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lock),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Nama',
                          style: warnaHitamStyle,
                        ),
                      ],
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.words,
                      controller: namaController,
                      maxLength: 25,
                      decoration: InputDecoration(
                        hintStyle: warnaHitamStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Handphone',
                          style: warnaHitamStyle,
                        )
                      ],
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: hpController,
                      maxLength: 13,
                      decoration: InputDecoration(
                        hintStyle: warnaHitamStyle,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Alamat',
                          style: warnaHitamStyle,
                        )
                      ],
                    ),
                    TextField(
                      textCapitalization: TextCapitalization.words,
                      controller: alamatController,
                      maxLength: 25,
                      decoration: InputDecoration(
                        hintStyle: warnaHitamStyle,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: TextButton(
                onPressed: () {
                  showSuccesDialog();
                  _updateNama(namaController.text);
                  _updateNomor(hpController.text);
                  _updateAlamat(alamatController.text);
                  _muatUpdate();
                },
                style: TextButton.styleFrom(
                    backgroundColor: warnaBiru,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ),
        ]));
  }
}
