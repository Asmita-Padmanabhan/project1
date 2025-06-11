import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import '../models/city_model.dart';
import '../services/city_api_service.dart';


class AudienceProfileScreen extends StatefulWidget {
  const AudienceProfileScreen({super.key});

  @override
  State<AudienceProfileScreen> createState() => _AudienceProfileScreenState();
}

class _AudienceProfileScreenState extends State<AudienceProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? _selectedCountry;
  String? _selectedCity;
  List<City> _cities = [];
  List<City> _citiesOriginal = [];
  bool _isLoadingCities = false;
  String? _errorMessage;

  Future<void> _fetchCities(String country) async {
    setState(() {
      _isLoadingCities = true;
      _errorMessage = null;
    });

    try {
      final cities = await CityApiService.fetchCities(country);
      setState(() {
        _cities = cities;
        _citiesOriginal = cities;
        _isLoadingCities = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load cities. Check your internet connection.';
        _isLoadingCities = false;
      });
    }
  }

  // Utility for filtering cities by name
  List<City> filterCities(List<City> cities, String query) {
    if (query.isEmpty) return cities;
    return cities
        .where((city) => city.cityName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _continue() {
    if (_formKey.currentState?.validate() ?? false) {
      // Add your navigation or save logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E9DA),
      appBar: AppBar(
        title: const Text('Audience Profile', style: TextStyle(fontFamily: 'AmaticSC', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF7B2E2E),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Name Field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    fillColor: Color(0xFFF5E9DA),
                    filled: true,
                  ),
                  onChanged: (value) => name = value,
                  validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 16),

                // Country Picker
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        setState(() {
                          _selectedCountry = country.name;
                          _selectedCity = null;
                          _cities.clear();
                        });
                        _fetchCities(country.name);
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF7B2E2E)),
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF5E9DA),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.flag, color: Color(0xFF7B2E2E)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedCountry ?? 'Select Country',
                            style: TextStyle(
                              color: _selectedCountry == null ? Colors.grey : const Color(0xFF7B2E2E),
                              fontFamily: 'AmaticSC',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF7B2E2E)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // City Dropdown (API-driven)
                if (_isLoadingCities)
                  const CircularProgressIndicator()
                else if (_errorMessage != null)
                  Text(_errorMessage!, style: const TextStyle(color: Colors.red))
                else if (_cities.isNotEmpty)
                  GestureDetector(
                    onTap: () async {
                      final String? selected = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          String filter = '';
                          List<City> filteredCities = _cities;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: const Text('Select City'),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                          labelText: 'Search city',
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            filter = value;
                                            filteredCities = _citiesOriginal
                                                .where((city) => city.cityName.toLowerCase().contains(filter.toLowerCase()))
                                                .toList();
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      Expanded(
                                        child: ListView(
                                          children: filteredCities.map((city) {
                                            return ListTile(
                                              title: Text(city.cityName),
                                              onTap: () => Navigator.of(context).pop(city.cityName),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                      if (selected != null) {
                        setState(() {
                          _selectedCity = selected;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF7B2E2E)),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFF5E9DA),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_city, color: Color(0xFF7B2E2E)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedCity ?? 'Select City',
                              style: TextStyle(
                                color: _selectedCity == null ? Colors.grey : const Color(0xFF7B2E2E),
                                fontFamily: 'AmaticSC',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down, color: Color(0xFF7B2E2E)),
                        ],
                      ),
                    ),
                  ),


                const SizedBox(height: 24),

                // Continue Button
                ElevatedButton(
                  onPressed: (_selectedCountry != null && _selectedCity != null && !_isLoadingCities && _errorMessage == null) ? _continue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B2E2E),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    shadowColor: const Color(0xFF7B2E2E).withOpacity(0.4),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'CONTINUE',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'AmaticSC', letterSpacing: 1.2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
