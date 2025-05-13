import 'package:flutter/material.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class StudentEnrollingViewmodel extends BaseViewModel {
  StudentEnrollingViewmodel({required Apiservice apiservice})
      : _apiservice = apiservice;
  final Apiservice _apiservice;

  final className = TextEditingController();
  final instructorName = TextEditingController();
  final instructorEmail = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  Future<void> registerInstructors(BuildContext context) async {
    final classNameText = className.text.trim();
    final instructorEmailText = instructorEmail.text.trim();
    final phoneNumber = phone.text.trim();
    final addressText = address.text.trim();

    if (classNameText.isEmpty || instructorEmailText.isEmpty) {
      debugPrint("One or more fields are empty.");
      return;
    }

    final instructors = [
      {
        "email": instructorEmailText,
        "first_name": classNameText,
      }
    ];
   await runBusyFuture(_apiservice.registerInstructors(
      classNameText,
      addressText,
      phoneNumber,
      instructors,
    ));

    debugPrint('Instructor registration completed.');
    notifyListeners();
  }

  void init() {
    _apiservice.getKeys();
  }
}
