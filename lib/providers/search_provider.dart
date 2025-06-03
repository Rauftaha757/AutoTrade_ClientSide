// search_provider.dart
import 'package:flutter/material.dart';
import 'package:pakwheels/modelclasses/car_ad_model.dart';
import 'package:pakwheels/services/CarAd_api.dart';

class SearchProvider extends ChangeNotifier {
  final CarAd_apiservice ad_apiservice = CarAd_apiservice();

  List<CarAd_model> _searchResults = [];
  List<CarAd_model> get searchResults => _searchResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasSearched = false;
  bool get hasSearched => _hasSearched;

  // Multi-field search method
  Future<void> searchCars({
    String? name,
    String? company,
    String? city,
    String? enginecapacity,
    required BuildContext context,
  }) async {
    _isLoading = true;
    _hasSearched = true;
    notifyListeners();

    final results = await CarAd_apiservice.getcarbysearch(
      name: name,
      company: company,
      city: city,
      enginecapacity: enginecapacity,
      context: context,
    );

    _searchResults = results;
    _isLoading = false;
    notifyListeners();
  }

  // Optional: Clear results
  void clearResults() {
    _searchResults = [];
    _hasSearched = false;
    notifyListeners();
  }
}
