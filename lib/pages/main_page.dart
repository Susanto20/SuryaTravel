import 'package:flutter/material.dart';
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
  var totalBayar;
  var valueJam;
  var valueTujuan;
  var valueKursi;
  int hargaTiket = 180000;
  List tujuanList = ['Pontianak', 'Sambas'];
  List jamList = [
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
  DateTime dateTime = DateTime.now();
  bool isTrue = false;

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
                          'Tujuan : $valueTujuan',
                          style: textAbuStyle,
                        ),
                        Text(
                          'Tanggal : ${dateTime.day.toString()}-${dateTime.month.toString()}-${dateTime.year.toString()}',
                          style: textAbuStyle,
                        ),
                        Text(
                          'Jam : $valueJam',
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
      if (valueTujuan == null || valueJam == null || valueKursi == null) {
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
        backgroundColor: warnaAbu,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: warnaBiru,
          title: Text(
            'Form Pesanan',
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
                            // dateTime: dateTime.day.toString(),
                            // valueTujuan: valueTujuan.toString(),
                            // valueJam: valueJam.toString(),
                            // valueKursi: valueKursi.toString(),
                            // totalBayar: totalBayar.toString(),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  'Lokasi Tujuan',
                  style: warnaHitamStyle.copyWith(
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
                      style: textAbuStyle,
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    underline: SizedBox(),
                    value: valueTujuan,
                    onChanged: (valueTujuanBaru) {
                      setState(() {
                        valueTujuan = valueTujuanBaru.toString();
                      });
                    },
                    items: tujuanList.map((valueItemTujuan) {
                      return DropdownMenuItem(
                          child: Text(valueItemTujuan), value: valueItemTujuan);
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
                  style: warnaHitamStyle.copyWith(
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
                              style: textAbuStyle.copyWith(),
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
                  style: warnaHitamStyle.copyWith(
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
                      style: textAbuStyle,
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    underline: SizedBox(),
                    value: valueJam,
                    onChanged: (valueJamBaru) {
                      setState(() {
                        valueJam = valueJamBaru as String;
                      });
                    },
                    items: jamList.map((valueItem) {
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
                  style: warnaHitamStyle.copyWith(
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
                    hint: Text(
                      "Pilih Jumlah Kursi",
                      style: textAbuStyle,
                    ),
                    underline: SizedBox(),
                    isExpanded: true,
                    value: valueKursi,
                    onChanged: (valueKursiBaru) {
                      print(valueKursiBaru);
                      setState(() {
                        valueKursi = valueKursiBaru as int;
                        totalBayar = valueKursi * hargaTiket;
                      });
                    },
                    items: <int>[1, 2, 3, 4, 5, 6].map((int valueKursi) {
                      return DropdownMenuItem<int>(
                        value: valueKursi,
                        child: Text(valueKursi.toString()),
                      );
                    }).toList(),
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
                        print('Tujuan : ${valueTujuan}');
                        print('Tanggal : ${dateTime.toString()}');
                        print('Jam : ${valueJam}');
                        print('Jumlah Kursi : ${valueKursi}');
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
      ),
    );
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue.shade900,
        content: Text(message.toString())));
  }
}
