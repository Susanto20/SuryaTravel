import 'package:flutter/material.dart';
import 'package:surya_travel/pages/main_page.dart';
import 'package:surya_travel/theme.dart';

class DetailOrderPage extends StatefulWidget {
  String? valueTujuan;
  String? valueJam;
  String? dateTime;
  String? valueKursi;
  String? nama;
  String? totalBayar;

  DetailOrderPage({
    required this.valueTujuan,
    required this.valueJam,
    required this.dateTime,
    required this.valueKursi,
    required this.nama,
    required this.totalBayar,
  });

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  Widget build(BuildContext context) {
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
        body: Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Detail Pesanan",
                          style: warnaBiruStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'No Handphone',
                      style: warnaHitamStyle,
                    ),
                    Text(
                      widget.nama.toString(),
                      style: textAbuStyle,
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
                      widget.valueTujuan.toString(),
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
                      widget.dateTime.toString(),
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
                      widget.valueJam.toString(),
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
                      widget.valueKursi.toString(),
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
                      widget.totalBayar.toString(),
                      style: textAbuStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
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
                      return MainPage();
                    },
                  ),
                );
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
