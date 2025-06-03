import 'package:flutter/cupertino.dart';
import 'package:pakwheels/modelclasses/user_model.dart';
import 'package:provider/provider.dart';
class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(name: "", email: "", password: "", id: "", token: "");

  UserModel get user => _user;
  void setUserFromJson(Map<String, dynamic> userData) {
    _user = UserModel.fromJson(userData);
    notifyListeners();
  }
  void setUserFromModel(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
