import 'package:flutter/material.dart';
import 'package:pharmacyonduty/helper/cities.dart';
import 'package:pharmacyonduty/screens/pharmacyscreen.dart';
import 'package:pharmacyonduty/welcomepage.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final List<String> sehirler = Sehirler().sehirler;
  List<String> filteredSehirler = [];

  @override
  void initState() {
    super.initState();
    filteredSehirler = sehirler;
  }

  void filterSehirler(String query) {
    setState(() {
      filteredSehirler = sehirler.where((sehir) {
        return sehir.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Şehir Seçiniz",
          style: TextStyle(color: Colors.yellow),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            onPressed: () async {
              final String? selected = await showSearch(
                context: context,
                delegate: SehirlerSearchDelegate(sehirler),
              );
              if (selected != null && selected.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PharmacyScreen(sehir: selected),
                ));
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredSehirler.length,
        itemBuilder: (context, index) {
          String sehir = filteredSehirler[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PharmacyScreen(sehir: sehir),
                ));
              },
              title: Text(sehir),
            ),
          );
        },
      ),
    );
  }
}

class SehirlerSearchDelegate extends SearchDelegate<String> {
  final List<String> sehirler;

  SehirlerSearchDelegate(this.sehirler);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> filteredSehirler = sehirler.where((sehir) {
      return sehir.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: filteredSehirler.length,
      itemBuilder: (context, index) {
        String sehir = filteredSehirler[index];
        return ListTile(
          title: Text(sehir),
          onTap: () {
            close(context, sehir);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> filteredSehirler = sehirler.where((sehir) {
      return sehir.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: filteredSehirler.length,
      itemBuilder: (context, index) {
        String sehir = filteredSehirler[index];
        return ListTile(
          title: Text(sehir),
          onTap: () {
            close(context, sehir);
          },
        );
      },
    );
  }
}
