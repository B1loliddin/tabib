import 'package:flutter/material.dart';
import 'package:tabib/models/user_model.dart';

class CurrentUserProvider extends ChangeNotifier {
  final UserModel _userModel = UserModel(
    id: '0',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    dateOfBirth: DateTime.now(),
    height: 0,
    weight: 0,
    gender: Gender.male,
  );

  UserModel get userModel => _userModel;

  void changeFirstLastNameEmailPassword(
    String firstName,
    String lastName,
    String email,
    String password,
  ) {
    userModel.firstName = firstName;
    userModel.lastName = lastName;
    userModel.email = email;
    userModel.password = password;

    notifyListeners();
  }

  void changeHeightWeightGender(
    DateTime dateOfBirth,
    int height,
    double weight,
    Gender gender,
  ) {
    userModel.dateOfBirth = dateOfBirth;
    userModel.height = height;
    userModel.weight = weight;
    userModel.gender = gender;

    notifyListeners();
  }
}
