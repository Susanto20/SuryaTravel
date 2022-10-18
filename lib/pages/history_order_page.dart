import 'package:flutter/material.dart';
import 'package:surya_travel/pages/detail_order_page.dart';
import 'package:surya_travel/theme.dart';

class HistoryOrderPage extends StatelessWidget {
  String? valueTujuan;
  String? valueJam;
  String? dateTime;
  String? valueKursi;
  String? nama;
  String? totalBayar;

  HistoryOrderPage({
    required this.valueTujuan,
    required this.valueJam,
    required this.dateTime,
    required this.valueKursi,
    required this.nama,
    required this.totalBayar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: warnaAbu,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: warnaBiru,
        title: Text(
          'Riwayat Pesanan',
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
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Terbaru",
              style: warnaBiruStyle.copyWith(
                fontSize: 21,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailOrderPage(
                        nama: nama,
                        valueTujuan: valueTujuan,
                        valueJam: valueJam,
                        dateTime: dateTime.toString(),
                        valueKursi: valueKursi,
                        totalBayar: totalBayar,
                      );
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID : 11223344',
                        style: textAbuStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Dalam Proses',
                        style: textAbuStyle.copyWith(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 28,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Terdahulu",
              style: warnaBiruStyle.copyWith(
                fontSize: 21,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID : 11223344',
                      style: textAbuStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Selesai',
                      style: textAbuStyle.copyWith(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
