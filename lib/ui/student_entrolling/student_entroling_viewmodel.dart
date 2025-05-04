import 'package:flutter/material.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:stacked/stacked.dart';

class StudentEntrolingViewmodel extends BaseViewModel {
  StudentEntrolingViewmodel({required Apiservice apiservice})
      : _apiservice = apiservice;
  final Apiservice _apiservice;

  final className = TextEditingController();
  final instrectorName = TextEditingController();
  final instrectorEmail = TextEditingController();
  final phone = TextEditingController();


  // adding a Multiple Instructor
 
  Future<void> registerInstructors() async {
    String classNameText = className.text;
    String instrectorNameText = instrectorName.text;
    String instrectorEmailText = instrectorEmail.text;

    if (classNameText.isEmpty ||
        instrectorNameText.isEmpty ||
        instrectorEmailText.isEmpty) {
      return;
    }
    List<Map<String, String>> instructors = [
      {"email": instrectorEmailText, "first_name": instrectorNameText}
    ];

    await runBusyFuture(
        _apiservice.registerInstructors(classNameText, instructors));
    debugPrint('Instructor registration completed.');

    notifyListeners();
  }

  void init() {
    _apiservice.getKeys();
  }
}
