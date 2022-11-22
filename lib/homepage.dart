import 'basenet.dart';
import 'detail.dart';
import 'volcanomodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<VolcanoModel> fetchVolcanoes() async {
  final response = await http.get(Uri.parse(
      'https://indonesia-public-static-api.vercel.app/api/volcanoes'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return VolcanoModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Volcanoes');
  }
}

class VolcanoModel {
  List<VolcanoModel>? volcanoes;

  String? nama;
  String? bentuk;
  String? tinggiMeter;
  String? estimasiLetusanTerakhir;
  String? geolokasi;

  VolcanoModel(
      {this.nama,
      this.bentuk,
      this.tinggiMeter,
      this.estimasiLetusanTerakhir,
      this.geolokasi});

  VolcanoModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    bentuk = json['bentuk'];
    tinggiMeter = json['tinggi_meter'];
    estimasiLetusanTerakhir = json['estimasi_letusan_terakhir'];
    geolokasi = json['geolokasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['bentuk'] = this.bentuk;
    data['tinggi_meter'] = this.tinggiMeter;
    data['estimasi_letusan_terakhir'] = this.estimasiLetusanTerakhir;
    data['geolokasi'] = this.geolokasi;
    return data;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<VolcanoModel> futureVolcano;

  @override
  void initState() {
    super.initState();
    futureVolcano = fetchVolcanoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Gunung Berapi di seluruh Indonesia"),
      ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: BaseNet.get(''),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            print(snapshot);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            VolcanoModel countriesModel = VolcanoModel.fromJson(snapshot.data);
            print(countriesModel);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(VolcanoModel data) {
    return ListView.builder(
      itemCount: data.volcanoes?.length,
      itemBuilder: (BuildContext context, int index) {
        final VolcanoModel? volcanoes = data.volcanoes?[index];
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => VolcanoDetail(volcanoes: volcanoes),
            //   ),
            // );
          },
          child: Center(
            child: Container(
              width: 480,
              margin: EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3foI62OKIxboByrfff-ik6x4zR6Ve1bF8Cg&usqp=CAU"),
                  ),
                  SizedBox(
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "${data.volcanoes?[index].nama}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemCountries(String value) {
    return Text(value);
  }
}
