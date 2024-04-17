import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pharmacyonduty/constants/apikey.dart';
import 'package:pharmacyonduty/models/pharmacymodel.dart';

class EczaneServis {
  Future<List<Model>> fetchData(String sehir) async {
    print(sehir);
    List<Model> modelList = [];

    Uri uri =
        Uri.parse("https://api.collectapi.com/health/dutyPharmacy?il=${sehir}");
    var response = await http.get(uri, headers: {
      'authorization': "apikey ${apikey}",
      'content-type': "application/json"
    });
    var json = jsonDecode(response.body);

    for (var element in json["result"]) {
      modelList.add(Model.fromJson(element));
    }

    return modelList;
  }
}
