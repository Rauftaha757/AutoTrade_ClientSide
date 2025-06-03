import 'package:flutter/cupertino.dart';
import 'package:pakwheels/services/CarAd_api.dart';

import '../modelclasses/car_ad_model.dart';

class CarAdProvider extends ChangeNotifier {

  List<CarAd_model> _ads = [];

  List<CarAd_model> get ads => _ads;

  void setAds(List<CarAd_model> ads) {
    _ads = ads;
    notifyListeners();
  }
  Future<void> fetchAds(BuildContext context) async {

    try {
      final ads = await CarAd_apiservice.getads(context); // this should return List<CarAd_model>
      _ads = ads;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching ads in provider: $e');
    }
  }



}
