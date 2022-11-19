import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:surya_travel/pages/history_order_page.dart';
import 'package:surya_travel/pages/profile_page.dart';
import 'package:surya_travel/pages/sign_in_page.dart';
import 'package:surya_travel/pages/upload_bukti_page.dart';
import 'package:surya_travel/services/service_api.dart';
import 'package:surya_travel/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tanggal : ',
                              style: textAbuStyle,
                            ),
                            Text(
                              // 'Tanggal : ${dateTime.day.toString()}-${dateTime.month.toString()}-${dateTime.year.toString()}',
                              // 'Tanggal : $dateTime',
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                              // style: textAbuStyle,

                              dateTime == null
                                  ? DateTime.now().toString()
                                  : DateFormat('yyyy/MM/dd').format(dateTime),
                              style: textAbuStyle.copyWith(),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
                        // Text(
                        //   'Silakan transfer ke nomor rekening ini : ',
                        //   style: textAbuStyle.copyWith(
                        //     fontSize: 12,
                        //   ),
                        // ),
                        // Text(
                        //   '1248998123',
                        //   style: textAbuStyle.copyWith(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: TextButton(
                              onPressed: () {
                                doPesan();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: warnaBiru,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              child: Text(
                                'Kirim',
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
                color: Color(0xff02018D),
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
                              dateTime == null
                                  ? DateTime.now().toString()
                                  : DateFormat('yyyy/MM/dd').format(dateTime),
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
                              firstDate: DateTime(dateTime.year - 2,
                                  dateTime.month, dateTime.day),
                              lastDate: DateTime(dateTime.year + 2,
                                  dateTime.month, dateTime.day));
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
                        print(
                            'Tanggal : ${dateTime.toString().replaceAll('00:00:00.000', '')}');
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

  Future doPesan() async {
    // String? tujuan = widget.valueTujuan;
    // String tanggal = widget.dateTime.toString().replaceAll('00:00:00.000', '');
    // String? jam = widget.valueJam;
    // String? kursi = widget.valueKursi;
    // String? total = widget.totalBayar;
    // print(image!);

    // if (tujuan == '' ||
    //     tanggal.isEmpty ||
    //     jam == '' ||
    //     kursi == '' ||
    //     total == '') {
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: Text(
    //             "Data Kosong",
    //             style: warnaHitamStyle,
    //           ),
    //           actions: [
    //             TextButton(
    //               onPressed: () => Navigator.pop(context),
    //               child: Text(
    //                 'Oke',
    //                 style: warnaHitamStyle,
    //               ),
    //             ),
    //           ],
    //         );
    //       });
    // }

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
      max: 1,
      msg: 'Loading',
      backgroundColor: warnaPutih,
      msgColor: warnaHitam,
      progressValueColor: warnaBiru,
    );
    final response =
        await http.post(Uri.parse(ServiceApi().getUrl + 'order/store'), body: {
      'tujuan': valueTujuan,
      'tanggal_berangkat': dateTime.toString().replaceAll('00:00:00.000', ''),
      'jam': valueJam,
      'jumlah_kursi': valueKursi.toString(),
      'total': totalBayar.toString(),
      'user_id': SpUtil.getString('id'),
      // 'file': image.toString(),
      'status': 'Terkirim',
    });

    progressDialog.close();
    if (response.statusCode == 200) {
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text(
      //           "Data Berhasil Disimpan",
      //           style: warnaHitamStyle,
      //         ),
      //         actions: [
      //           TextButton(
      //             onPressed: () => Navigator.pop(context),
      //             child: Text(
      //               'Oke',
      //               style: warnaHitamStyle,
      //             ),
      //           ),
      //         ],
      //       );
      //     });

      showDialog(
          context: context,
          builder: (BuildContext context) => Container(
                width: 280,
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
                          'Data Terkirim',
                          style: warnaHitamStyle.copyWith(fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Antrian Konfirmasi Pesanan',
                              overflow: TextOverflow.ellipsis,
                              style: warnaHitamStyle.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Mohon menunggu sebentar, anda sedang dalam antrian konfirmasi pesanan oleh admin, terima kasih.',
                            textAlign: TextAlign.justify,
                            style: warnaHitamStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HistoryOrderPage(
                                      // valueTujuan: widget.valueTujuan,
                                      // valueJam: widget.valueJam,
                                      // dateTime: widget.dateTime,
                                      // valueKursi: widget.valueKursi,
                                      // totalBayar: widget.totalBayar,
                                      );
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: 50,
                            child: Image.asset(
                              'assets/images/check.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));

      print(SpUtil.getString('id'));
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

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue.shade900,
        content: Text(message.toString())));
  }
}
