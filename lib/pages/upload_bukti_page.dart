import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'package:surya_travel/pages/history_order_page.dart';
import 'package:surya_travel/theme.dart';
import 'package:http/http.dart' as http;

class UploadBuktiPage extends StatefulWidget {
  String valueTujuan;
  String valueJam;
  String dateTime;
  String valueKursi;
  String totalBayar;

  UploadBuktiPage({
    required this.valueTujuan,
    required this.valueJam,
    required this.dateTime,
    required this.valueKursi,
    required this.totalBayar,
  });

  @override
  State<UploadBuktiPage> createState() => _UploadBuktiPageState();
}

class _UploadBuktiPageState extends State<UploadBuktiPage> {
  File? image;
  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  // void simpanData() async {
  //   final pref = await SharedPreferences.getInstance();

  //   var valueTujuan = widget.valueTujuan;
  //   var dateTime = widget.dateTime;
  //   var valuejam = widget.valueJam;
  //   var valueKursi = widget.valueKursi;
  //   var totalBayar = widget.totalBayar;

  //   final dataOrder = json.encode({
  //     'valueTujuan': valueTujuan,
  //     'dateTime': dateTime,
  //     'valueJam': valuejam,
  //     'valueKursi': valueKursi,
  //     'totalBayar': totalBayar,
  //   });

  //   pref.setString(dataOrder, dataOrder);

  //   setState(() {});
  // }

  // void ambilData() async {
  //   final pref = await SharedPreferences.getInstance();

  //   final dataOrder =
  //       json.decode(pref.getString('dataOrder')) as Map<String, dynamic>;

  //   'valueTujuan' = dataOrder['valueTujuan'];
  //   'dateTime' = dataOrder['dateTime'];
  //   'valueJam' = dataOrder['valueJam'];
  //   'valueKursi' = dataOrder['valueKursi'];
  //   'totalBayar' = dataOrder['totalBayar'];
  // }

  @override
  Widget build(BuildContext context) {
    Future<void> showSuccesDialog() async {
      return showDialog(
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
                              'Antrian Verifikasi Pembayaran : ',
                              overflow: TextOverflow.ellipsis,
                              style: warnaHitamStyle.copyWith(fontSize: 14),
                            ),
                            Text(
                              '1',
                              style: warnaHitamStyle.copyWith(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Mohon menunggu sebentar, anda sedang dalam antrian verfikasi pembayaran oleh admin, terima kasih.',
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
                            Navigator.push(
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
                            height: 90,
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

    Future saveData() async {
      if (image == null) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Masukkan bukti pembayaran",
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
        doPesan();
        // showSuccesDialog();
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: warnaAbu,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: warnaBiru,
          title: Text(
            'Pembayaran',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Center(
                child: Text(
                  'Upload Bukti Pembayaran',
                  style: warnaHitamStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await getImage();
              },
              child: Container(
                padding: EdgeInsets.symmetric(),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: warnaHitam,
                    width: 1,
                  ),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image != null
                        ? Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                height: 40,
                                child: Image.asset(
                                  'assets/images/photo.png',
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Pilih Gambar',
                                style: warnaHitamStyle,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 80,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                color: warnaBiru,
              ),
              child: TextButton(
                  onPressed: () {
                    // print('Tujuan : ${widget.valueTujuan}');
                    // print('Tanggal : ${widget.dateTime}');
                    // print('Jumlah Kursi : ${widget.valueKursi}');
                    // print('Jam : ${widget.valueJam}');
                    // print('Total Bayar : ${widget.totalBayar}');
                    // print(image);
                    saveData();
                    // doPesan();
                  },
                  child: Text(
                    'Kirim',
                    style: warnaPutihStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // _muatData() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     widget.valueTujuan = (pref.getString('valueTujuan') ?? '');
  //     widget.dateTime = (pref.getString('datetime') ?? '');
  //     widget.valueJam = (pref.getString('valueJam') ?? '');
  //     widget.valueKursi = (pref.getString('valueKursi') ?? '');
  //     widget.totalBayar = (pref.getString('TotalBayar') ?? '');
  //   });
  // }

  Future doPesan() async {
    String? tujuan = widget.valueTujuan;
    String tanggal = widget.dateTime.toString();
    String? jam = widget.valueJam;
    String? kursi = widget.valueKursi;
    String? total = widget.totalBayar;
    print(total);
    print(tujuan);

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

    final response = await http.post(
      Uri.parse(
          'https://e878-202-67-35-8.ap.ngrok.io/surya-travel/public/api/order/store'),
      body: {
        'tujuan': widget.valueTujuan,
        'tanggal_berangkat': widget.dateTime,
        'jam': widget.valueJam,
        'jumlah_kursi': widget.valueKursi,
        'total': widget.totalBayar,
        'user_id': SpUtil.getString('id'),
        // 'file': image,
        'status': 'diterima',
      },
      // headers: {
      //   'Accept': 'application/json',
      //   'Content-Type': 'application/json'
      // },
    );

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
                              'Antrian Verifikasi Pembayaran : ',
                              overflow: TextOverflow.ellipsis,
                              style: warnaHitamStyle.copyWith(fontSize: 14),
                            ),
                            Text(
                              '1',
                              style: warnaHitamStyle.copyWith(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'Mohon menunggu sebentar, anda sedang dalam antrian verfikasi pembayaran oleh admin, terima kasih.',
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
                            Navigator.push(
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
                            height: 90,
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
}
