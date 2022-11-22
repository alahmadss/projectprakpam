import 'package:flutter/material.dart';
import 'volcanomodel.dart';

class VolcanoDetail extends StatefulWidget {
  final VolcanoModel? volcanoes;
  const VolcanoDetail({Key? key, required this.volcanoes}) : super(key: key);

  @override
  State<VolcanoDetail> createState() => _VolcanoDetailState();
}

class _VolcanoDetailState extends State<VolcanoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.volcanoes?.nama}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        height: 300,
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3foI62OKIxboByrfff-ik6x4zR6Ve1bF8Cg&usqp=CAU")),
                    Padding(padding: const EdgeInsets.only(top: 1.0)),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Gunung\t   : ${widget.volcanoes?.nama}",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          "Jenis Gunung berapi     : ${widget.volcanoes?.bentuk}",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          "Tinggi (Meter) : ${widget.volcanoes?.tinggiMeter}",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          "Letusan terakhir   : ${widget.volcanoes?.estimasiLetusanTerakhir}",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Geo Lokasi\t   : ${widget.volcanoes?.geolokasi}",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                          textAlign: TextAlign.right,
                        ),
                        Text(""),
                      ],
                    ),
                    // Text(
                    //   (widget.movie?.dateOfBirth != null) ? "${widget.movie?.dateOfBirth}" : "TBA",
                    //   style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,
                    // ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
