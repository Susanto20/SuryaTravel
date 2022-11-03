import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatelessWidget {
  final String apiUrl =
      "https://42b0-2001-448a-6080-4c83-f05f-38b5-dd9e-a08f.ap.ngrok.io/surya-travel/public/api/order/show?uid=18";

  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar GET HTTP'),
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
                    return ListTile(
                      // leading: CircleAvatar(
                      //   radius: 30,
                      //   backgroundImage:
                      //       NetworkImage(snapshot.data[index]['avatar']),
                      // ),
                      title: Text(snapshot.data[index]['id'].toString()),
                      subtitle: Text(snapshot.data[index]['status']),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
