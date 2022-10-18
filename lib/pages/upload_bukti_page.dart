import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surya_travel/pages/history_order_page.dart';
import 'package:surya_travel/theme.dart';

class UploadBuktiPage extends StatefulWidget {
  String? valueTujuan;
  String? valueJam;
  String? dateTime;
  String? valueKursi;
  String? nama;
  String? totalBayar;

  UploadBuktiPage({
    required this.valueTujuan,
    required this.valueJam,
    required this.dateTime,
    required this.nama,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nomor Antrian : ',
                              style: warnaHitamStyle,
                            ),
                            Text(
                              '1',
                              style: warnaHitamStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Mohon menunggu sebentar, anda sedang dalam antrian verfikasi pembayaran oleh admin, terima kasih.',
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
                                  return HistoryOrderPage(
                                    nama: widget.nama,
                                    valueTujuan: widget.valueTujuan,
                                    valueJam: widget.valueJam,
                                    dateTime: widget.dateTime,
                                    valueKursi: widget.valueKursi,
                                    totalBayar: widget.totalBayar,
                                  );
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
        showSuccesDialog();
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
                    setState(() {
                      saveData();
                    });
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
}
