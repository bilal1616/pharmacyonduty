import 'package:flutter/material.dart';
import 'package:pharmacyonduty/models/pharmacymodel.dart';
import 'package:provider/provider.dart';
import 'package:pharmacyonduty/provider/city_provider.dart';
import 'package:pharmacyonduty/service/pharmacyservice.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cityProvider = Provider.of<CityProvider>(context);
    final selectedCity = cityProvider.selectedCity;

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
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: EczaneServis().fetchData(selectedCity!),
        builder: (context, AsyncSnapshot<List<Model>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pharmacy data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pharmacy = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(pharmacy.name ?? ''),
                    subtitle: Text(pharmacy.address ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
