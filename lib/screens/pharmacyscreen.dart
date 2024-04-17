import 'package:flutter/material.dart';
import 'package:pharmacyonduty/models/pharmacymodel.dart';
import 'package:pharmacyonduty/service/pharmacyservice.dart';

class PharmacyScreen extends StatefulWidget {
  final String? sehir;
  const PharmacyScreen({Key? key, required this.sehir}) : super(key: key);

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  List<Model> eczaneList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    eczaneList = await EczaneServis().fetchData(widget.sehir!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Nöbetçi Eczaneler",
          style: TextStyle(color: Colors.yellow),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Arrow icon'unu beyaz yap
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: eczaneList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: eczaneList.length,
              itemBuilder: (context, index) {
                Model sehir = eczaneList[index];
                return myCard(sehir);
              }),
    );
  }

  Card myCard(Model sehir) {
    return Card(
        child: ListTile(
            title: Text(sehir.name ?? ""),
            subtitle: Text(sehir.address ?? "")));
  }
}
