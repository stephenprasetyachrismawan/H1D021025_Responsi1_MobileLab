import 'dart:convert';
import 'package:responsi1/helpers/api.dart';
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/ikan.dart';

class IkanBloc {
  static Future<List<Ikan>> getIkans() async {
    String apiUrl = ApiUrl.listIkan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listIkan = (jsonObj as Map<String, dynamic>)['data'];
    List<Ikan> ikans = [];
    for (int i = 0; i < listIkan.length; i++) {
      ikans.add(Ikan.fromJson(listIkan[i]));
    }
    return ikans;
  }

  static Future addIkan({Ikan? ikan}) async {
    String apiUrl = ApiUrl.createIkan;
    var body = {
      "nama": ikan!.namaIkan,
      "jenis": ikan.jenisIkan,
      "habitat": ikan.habitatIkan,
      "warna": ikan.warnaIkan,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateIkan({required Ikan ikan}) async {
    String apiUrl = ApiUrl.updateIkan(int.parse(ikan.id!));

    var body = {
      "nama": ikan.namaIkan,
      "jenis": ikan.jenisIkan,
      "habitat": ikan.habitatIkan,
      "warna": ikan.warnaIkan,
    };

    var response = await Api().put(apiUrl, jsonEncode(body));

    var jsonObj = json.decode(response.body);

    return jsonObj['status'];
  }

  static Future<dynamic> deleteIkan({int? id}) async {
    String apiUrl = ApiUrl.deleteIkan(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
