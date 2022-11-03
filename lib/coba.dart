import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Coba extends StatefulWidget {
  const Coba({Key? key}) : super(key: key);

  @override
  State<Coba> createState() => _CobaState();
}

class _CobaState extends State<Coba> {
  // late String stringResponse;

  var listResponse;

  Future fetchData() async {
    http.Response response;
    response =
        await http.get(Uri.parse("https://api-porto.bimarf.in/api/tweet/get"));
    if (response.statusCode == 200) {
      setState(() {
        listResponse = jsonDecode(response.body);
        // print(jsonDecode(response.body)['tweet']);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(listResponse.toString()),
        ),
      ),
    );
  }
}
