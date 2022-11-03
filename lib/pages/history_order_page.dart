import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:surya_travel/pages/detail_order_page.dart';
import 'package:surya_travel/theme.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

class HistoryOrderPage extends StatelessWidget {
  // String? valueTujuan;
  // String? valueJam;
  // String? dateTime;
  // String? valueKursi;
  // String? totalBayar;

  // HistoryOrderPage({
  //   required this.valueTujuan,
  //   required this.valueJam,
  //   required this.dateTime,
  //   required this.valueKursi,
  //   required this.totalBayar,
  // });
  final String apiUrl =
      "https://42b0-2001-448a-6080-4c83-f05f-38b5-dd9e-a08f.ap.ngrok.io/surya-travel/public/api/order/show?uid=18";

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

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
        child: FutureBuilder<List<dynamic>>(
          future: _fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailOrderPage();
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   radius: 30,
                          //   backgroundImage:
                          //       NetworkImage(snapshot.data[index]['avatar']),
                          // ),
                          title: Text(
                              'ID : ' + snapshot.data[index]['id'].toString()),
                          subtitle: Text(snapshot.data[index]['status']),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      // body: Container(
      //   margin: EdgeInsets.symmetric(
      //     horizontal: 15,
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(
      //         height: 5,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return DetailOrderPage(
      //                     // valueTujuan: valueTujuan,
      //                     // valueJam: valueJam,
      //                     // dateTime: dateTime.toString(),
      //                     // valueKursi: valueKursi,
      //                     // totalBayar: totalBayar,
      //                     );
      //               },
      //             ),
      //           );
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'ID : 1',
      //                   style: textAbuStyle.copyWith(
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //                 Text(
      //                   'Dalam Proses',
      //                   style: textAbuStyle.copyWith(
      //                     fontSize: 14,
      //                   ),
      //                 )
      //               ],
      //             ),
      //             Icon(
      //               Icons.keyboard_arrow_right_outlined,
      //               size: 28,
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
