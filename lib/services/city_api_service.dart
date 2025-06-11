import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/city_model.dart';

class CityApiService {
  static Future<List<City>> fetchCities(String country) async {
    final url = Uri.parse('https://countriesnow.space/api/v0.1/countries/cities');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'country': country}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List cities = data['data'];
      return cities.map((cityName) => City(cityName: cityName)).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
