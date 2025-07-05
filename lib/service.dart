import 'dart:convert';

import 'package:http/http.dart' as http;

class DataModel {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;

  DataModel({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: json['color'],
      pantoneValue: json['pantone_value'],
    );
  }
}

class Service {
  String baseUrl = 'https://reqres.in/api';

  Future<List<DataModel>> fetchDataModelList() async {
    try {
      final url = Uri.parse('$baseUrl/unknown');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> dataList = jsonData['data'];
        return dataList.map((item) => DataModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}
