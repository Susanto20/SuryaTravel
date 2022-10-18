import 'package:flutter/material.dart';
import 'package:surya_travel/pages/login_page.dart';
import 'package:surya_travel/pages/history_order_page.dart';
import 'package:surya_travel/pages/profile_page.dart';
import 'package:surya_travel/pages/sign_in_page.dart';
import 'package:surya_travel/pages/upload_bukti_page.dart';
import 'package:surya_travel/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var emailController = TextEditingController(text: '');
  var noHpController = TextEditingController(text: '');
  var totalBayar;
  var valueTujuan;
  var valueJam;
  var valueKursi;
  int hargaTiket = 180000;
  List tujuanList = ['Pontianak', 'Sambas'];
  List? jamList = [
    '00.00',
    '02.00',
    '04.00',
    '06.00',
    '08.00',
    '10.00',
    '12.00',
    '14.00',
    '16.00',
    '18.00',
    '20.00',
    '22.00',
  ];

  DateTime dateTime = DateTime(2022);
  bool isTrue = false;
  TextEditingController nama = TextEditingController();

  logOut() async {
    SpUtil.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.clear();
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SignInPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          'Pesanan Anda',
                          style: warnaBiruStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Tujuan : ${valueTujuan}',
                          style: textAbuStyle,
                        ),
                        Text(
                          'Tanggal : ${dateTime.day.toString()}-${dateTime.month.toString()}-${dateTime.year.toString()}',
                          style: textAbuStyle,
                        ),
                        Text(
                          'Jam : ${valueJam}',
                          style: textAbuStyle,
                        ),
                        Text(
                          'Jumlah Kursi : ${valueKursi.toString()}',
                          style: textAbuStyle,
                        ),
                        Text(
                          'Total Bayar : Rp. ${valueKursi * hargaTiket}',
                          style: textAbuStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Silakan transfer ke nomor rekening ini : ',
                          style: textAbuStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '1248998123',
                          style: textAbuStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return UploadBuktiPage(
                                        nama: nama.text,
                                        valueTujuan: valueTujuan,
                                        valueJam: valueJam,
                                        dateTime: dateTime.day.toString(),
                                        valueKursi: valueKursi.toString(),
                                        totalBayar: totalBayar.toString(),
                                      );
                                    },
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: warnaBiru,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              child: Text(
                                'Upload Bukti Pembayaran',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    }

    Future saveData() async {
      if (nama.text == '' ||
          valueTujuan == '' ||
          valueJam == '' ||
          valueKursi == '') {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Harap diisi dengan lengkap",
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
      } else {
        showSuccesDialog();
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: warnaAbu,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: warnaBiru,
          title: Text(
            'Surya Travel',
            style: warnaPutihStyle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: warnaBiru,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                color: Color(0xff3AA0CB),
                alignment: Alignment.bottomLeft,
                child: Padding(
                  child: Text(
                    'Hai, ' + SpUtil.getString('name')!,
                    style: warnaPutihStyle.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfilePage();
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: warnaPutih,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profil',
                        style: warnaPutihStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HistoryOrderPage(
                          nama: nama.toString(),
                          dateTime: dateTime.toString(),
                          valueTujuan: valueTujuan.toString(),
                          valueJam: valueJam.toString(),
                          valueKursi: valueKursi.toString(),
                          totalBayar: totalBayar.toString(),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: warnaPutih,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Riwayat Pesanan',
                        style: warnaPutihStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  logOut();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: warnaPutih,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Keluar',
                        style: warnaPutihStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                'No Handphone',
                style: textAbuStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: nama,
                style: warnaHitamStyle,
                decoration: InputDecoration(
                  hintStyle: warnaHitamStyle,
                  border: InputBorder.none,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: warnaPutih,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                'Lokasi Tujuan',
                style: textAbuStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: warnaPutih,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                  hint: Text(
                    'Pilih Lokasi Tujuan',
                    style: warnaHitamStyle,
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  underline: SizedBox(),
                  value: valueTujuan,
                  onChanged: (valueTujuanBaru) {
                    setState(() {
                      valueTujuan = valueTujuanBaru;
                    });
                  },
                  items: tujuanList.map((valueItem) {
                    return DropdownMenuItem(
                        child: Text(valueItem), value: valueItem);
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                'Tanggal Keberangkatan',
                style: textAbuStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: warnaPutih,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                            style: warnaHitamStyle.copyWith(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: warnaBiru,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      onPressed: () async {
                        DateTime? newData = await showDatePicker(
                            context: context,
                            initialDate: dateTime,
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2023));
                        if (newData != null) {
                          setState(() {
                            dateTime = newData;
                          });
                        }
                      },
                      child: Text(
                        'Pilih Tanggal',
                        style: warnaPutihStyle,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                'Jam Keberangkatan',
                style: textAbuStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: warnaPutih,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton(
                  hint: Text(
                    'Pilih Jam',
                    style: warnaHitamStyle,
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  underline: SizedBox(),
                  value: valueJam,
                  onChanged: (valueJamBaru) {
                    setState(() {
                      valueJam = valueJamBaru;
                    });
                  },
                  items: jamList!.map((valueItem) {
                    return DropdownMenuItem(
                        child: Text(valueItem), value: valueItem);
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                'Jumlah Kursi',
                style: textAbuStyle.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: warnaPutih,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<int>(
                  hint: Text("Pilih Jumlah Kursi"),
                  underline: SizedBox(),
                  isExpanded: true,
                  value: valueKursi,
                  items: <int>[1, 2, 3, 4, 5, 6].map((int value) {
                    return new DropdownMenuItem<int>(
                      value: value,
                      child: new Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (valueKursiBaru) {
                    print(valueKursi);
                    setState(() {
                      valueKursi = valueKursiBaru;
                      totalBayar = valueKursi * hargaTiket;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      saveData();
                    });
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: warnaBiru,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    'Pesan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue.shade900,
        content: Text(message.toString())));
  }
}
