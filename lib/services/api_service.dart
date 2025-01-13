import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiServices {
  final endpoint = 'https://timeapi.io/api/Time/current/zone?timeZone=';

  Future<List<String>> getTime(String zone) async {
    List<String> values = [];
    // request and get response
    Logger().f("$endpoint$zone");
    try {
      final response = await http.get(Uri.parse('$endpoint$zone'));
      //check response status code
      if (response.statusCode == 200) {
        //convert response.body to map via jsonDecode()
        Map<String, dynamic> data = jsonDecode(response.body);
        data.forEach((key, value) {
          values.add("$key - $value");
        });
        return values;
      } else {
        return ["Error - ${response.statusCode}"];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
