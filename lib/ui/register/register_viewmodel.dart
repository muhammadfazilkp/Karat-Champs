import 'package:flutter/material.dart';
import 'package:karatte_kid/models/belt_model.dart';
import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

import '../../models/class_model.dart';

class RegisterViewmodel extends BaseViewModel {
  RegisterViewmodel({required Apiservice apiservice})
      : _apiservice = apiservice;
  final Apiservice _apiservice;

  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController institute = TextEditingController();
  final TextEditingController reletion = TextEditingController();
  final TextEditingController belt = TextEditingController();
  final TextEditingController registerDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  final formKey = GlobalKey<FormState>();
  ClassModel? classModel;
  dynamic selectedItem;
  Guardian? guardian;
  void confirmSelection() {
    institute.text = selectedItem;
    notifyListeners();
  }

  Future<void> register(
      {required String name,
      required String email,
      required String phone,
      required String institute}) async {
    final status = await runBusyFuture(_apiservice.getStudentResorce(
        fullname: name, email: email, phone: phone, institute: institute));
    // if (status == true) {

    // }
  }

  Future<void> init() async {
    await getClassDetails();
    guardian = await _apiservice.getGuardinDetails();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
        registerDate.text = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

      notifyListeners();
    }
  }

  Future<void> getClassDetails() async {
    classModel = await runBusyFuture(_apiservice.getClassDetails());
    notifyListeners();
  }
}
