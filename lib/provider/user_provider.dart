import 'package:flutter/material.dart';
import 'package:moive_app/model/firebase_model/user_model.dart';

class UserProvider extends ChangeNotifier{
  Users? currentUser;
  void updateUser(Users newUser){
    currentUser = newUser;
    notifyListeners();
  }

}