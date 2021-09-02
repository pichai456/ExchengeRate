import 'dart:convert';
import 'package:learn/models/ExchengeRate.dart';
import 'package:http/http.dart' as http;

class ApiException {
  static Future<ExchengeRate> getExchangeRate() async {
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');
    final response = await http.get(url);
    return ExchengeRate.fromJson(jsonDecode(response.body));
  }
}
