import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rifadwiutami_2410910040027_ujian_api/models/todolist_models.dart';

class ProductHelper {
  // fungsi mengambil seluruh list produk
  Future<List<TodosModel>> getAllProduct()async {
    //siapkan url endpoint produk
    var uri =  Uri.parse("https://jsonplaceholder.typicode.com/todos");
    var respon = await http.get(uri);
    if(respon.statusCode == 200) {
      List<dynamic> hasil = jsonDecode (respon.body);
      return hasil.map((json) =>
      TodosModel.fromMap(json)).toList();
    }else{
      throw Exception("Koneksi Terganggu");
    }
  }
}