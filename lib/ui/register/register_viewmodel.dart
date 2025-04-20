import 'package:flutter/material.dart';
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
  final formKey = GlobalKey<FormState>();
  ClassModel? classModel;
  dynamic selectedItem;
  void confirmSelection() {
    institute.text = selectedItem;
    notifyListeners();
  }

  Future<void> register(
      {required String name,
      required String email,
      required String phone,
      required String institute}) async {
    runBusyFuture(_apiservice.getStudentResorce(
        fullname: name, email: email, phone: phone, institute: institute));
  }

  Future<void> init() async {
    await getClassDetails();
  }

  Future<void> getClassDetails() async {
    classModel = await runBusyFuture(_apiservice.getClassDetails());
    notifyListeners();
  }
}
