import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:surya_travel/pages/history_order_page.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:surya_travel/theme.dart';

class DetailOrderPage extends StatefulWidget {
  // String? valueTujuan;
  // String? valueJam;
  // String? dateTime;
  // String? valueKursi;

  // String? totalBayar;

  // DetailOrderPage({
  //   required this.valueTujuan,
  //   required this.valueJam,
  //   required this.dateTime,
  //   required this.valueKursi,
  //   required this.totalBayar,
  // });

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final String apiUrl =
      "https://42b0-2001-448a-6080-4c83-f05f-38b5-dd9e-a08f.ap.ngrok.io/surya-travel/public/api/order/show?uid=10";

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
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
                          'Transaksi Selesai',
                          style: warnaHitamStyle,
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
                          },
                          child: Container(
                            height: 100,
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: warnaAbu,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: warnaBiru,
          title: Text(
            'Detail Pesanan',
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
        body: Container(
          child: FutureBuilder<List<dynamic>>(
            future: _fecthDataUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Detail Pesanan",
                            style: warnaBiruStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Lokasi Tujuan',
                            style: warnaHitamStyle,
                          ),
                          Text(
                            snapshot.data[index]['tujuan'].toString(),
                            style: textAbuStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Tanggal',
                            style: warnaHitamStyle,
                          ),
                          Text(
                            snapshot.data[index]['tanggal_berangkat']
                                .toString(),
                            style: textAbuStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Jam Keberangkatan',
                            style: warnaHitamStyle,
                          ),
                          Text(
                            snapshot.data[index]['jam'].toString(),
                            style: textAbuStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Jumlah Kursi',
                            style: warnaHitamStyle,
                          ),
                          Text(
                            snapshot.data[index]['jumlah_kursi'].toString(),
                            style: textAbuStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Total Bayar',
                            style: warnaHitamStyle,
                          ),
                          Text(
                            snapshot.data[index]['total'].toString(),
                            style: textAbuStyle,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        // body: Card(
        //   elevation: 5,
        //   margin: EdgeInsets.all(10),
        //   child: ListView(
        //     children: [
        //       Container(
        //         margin: EdgeInsets.symmetric(
        //           horizontal: 15,
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(
        //               "Detail Pesanan",
        //               style: warnaBiruStyle.copyWith(
        //                 fontSize: 18,
        //               ),
        //             ),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(
        //               'Lokasi Tujuan',
        //               style: warnaHitamStyle,
        //             ),
        //             // Text(
        //             // widget.valueTujuan.toString(),
        //             // style: textAbuStyle,
        //             // ),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(
        //               'Tanggal',
        //               style: warnaHitamStyle,
        //             ),
        //             // Text(
        //             //   widget.dateTime.toString(),
        //             //   style: textAbuStyle,
        //             // ),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(
        //               'Jam Keberangkatan',
        //               style: warnaHitamStyle,
        //             ),
        //             // Text(
        //             //   widget.valueJam.toString(),
        //             //   style: textAbuStyle,
        //             // ),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(
        //               'Jumlah Kursi',
        //               style: warnaHitamStyle,
        //             ),
        //             // Text(
        //             //   widget.valueKursi.toString(),
        //             //   style: textAbuStyle,
        //             // ),
        //             SizedBox(
        //               height: 5,
        //             ),
        //             Text(
        //               'Total Bayar',
        //               style: warnaHitamStyle,
        //             ),
        //             // Text(
        //             //   widget.totalBayar.toString(),
        //             //   style: textAbuStyle,
        //             // ),
        //             SizedBox(
        //               height: 30,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: TextButton(
              onPressed: () {
                showSuccesDialog();
              },
              style: TextButton.styleFrom(
                  backgroundColor: warnaBiru,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                'Selesai',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }
}
