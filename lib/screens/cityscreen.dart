import 'package:flutter/material.dart';
import 'package:pharmacyonduty/screens/pharmacyscreen.dart';
import 'package:pharmacyonduty/welcomepage.dart';
import 'package:provider/provider.dart';
import 'package:pharmacyonduty/provider/city_provider.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cityProvider = Provider.of<CityProvider>(context);

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
            Navigator.push(
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
              final selected = await showSearch(
                context: context,
                delegate: SehirlerSearchDelegate(cityProvider.cities),
              );
              if (selected != null && selected.isNotEmpty) {
                cityProvider.selectCity(selected);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PharmacyScreen(),
                ));
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cityProvider.cities.length,
        itemBuilder: (context, index) {
          final sehir = cityProvider.cities[index];
          return ListTile(
            leading: Text(
              sehir,
              style: TextStyle(fontSize: 16),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(2),
              child: Image.asset(
                'assets/${sehir.toLowerCase()}.jpg', // Örneğin, Ankara için 'ankara.jpg'
                width: 150,
                height: 400,
                fit: BoxFit.fill,
              ),
            ),
            onTap: () {
              cityProvider.selectCity(sehir);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PharmacyScreen(),
              ));
            },
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
