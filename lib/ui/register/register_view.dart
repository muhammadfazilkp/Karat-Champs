import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/app/utils.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/register/register_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/diologs.dart';
import '../belt_listing/belt_listview.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({required this.institute, super.key});
  final String? institute;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewmodel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      viewModelBuilder: () =>
          RegisterViewmodel(apiservice: Provider.of(context)),
      builder: (context, model, _) {
        debugPrint("Institute: $institute");
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.sp,
            backgroundColor: Colors.transparent,
            title: Text(
              "Register",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.poppins,
                  fontSize: 18.sp),
            ),
            leading: IconButton(
                onPressed: () {
                  navigationService.goBack(result: false);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 25,
                  color: Colors.white,
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/profile_new.png',
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfileld(
                      hintText: 'Name',
                      type: TextInputType.streetAddress,
                      controller: model.fullname,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextfileld(
                      hintText: 'E-mail',
                      type: TextInputType.emailAddress,
                      controller: model.email,
                      validator: (email) {
                        return validateEmail(email);
                      },
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextfileld(
                      hintText: 'Phone number',
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Required field';
                        } else if (p0.length < 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                      controller: model.phone,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextfileld(
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        onTap: () {
                          model.selectDate(context);
                        },
                        readOnly: false,
                        hintText: 'Select Registration Date',
                        type: TextInputType.phone,
                        controller: model.registerDate),
                    SizedBox(
                      height: 10.sp,
                    ),
                    // CustomTextfileld(
                    //   suffixIcon: const Icon(
                    //     Icons.arrow_drop_down,
                    //     color: Colors.black,
                    //   ),
                    //   readOnly: true,
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       context: context,
                    //       builder: (context) =>
                    //           selecTingWidget(model: model, context: context),
                    //       isScrollControlled: true,
                    //       shape: const RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.vertical(top: Radius.circular(20)),
                    //       ),
                    //     );
                    //   },
                    //   hintText: 'Select Institute',
                    //   type: TextInputType.streetAddress,
                    //   controller: model.institute,
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    CustomTextfileld(
                      hintText: 'Gurdian Name',
                      type: TextInputType.emailAddress,
                      controller: model.gurdian,
                      // validator: (email) {
                      //   return validateEmail(email);
                      // },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextfileld(
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            readOnly: false,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BeltSelector(
                                      selectedBelt: model.belt.text,
                                      onSelected: (selectedBelt) {
                                        model.belt.text = selectedBelt;
                                        model.notifyListeners();
                                      });
                                },
                              );
                            },
                            hintText: 'Select Belt',
                            type: TextInputType.text,
                            controller:
                                TextEditingController(text: model.belt.text),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextfileld(
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            readOnly: true,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => selectRelation(
                                  gurdianList: model.guardian?.data ?? [],
                                  context: context,
                                  title: 'Select Relation',
                                  selectedRelation: model.reletion.text,
                                  onSelected: (selected) {
                                    model.reletion.text = selected;
                                    model.notifyListeners();
                                  },
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                              );
                            },
                            hintText: 'Select Relation',
                            type: TextInputType.text,
                            controller: TextEditingController(
                                text: model.reletion.text),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        model.isBusy;
                        if (model.formKey.currentState!.validate()) {
                          model.register(
                            name: model.fullname.text,
                            email: model.email.text,
                            phone: model.phone.text,
                            institute: institute.toString(),
                            belt: model.belt.text,
                            date:
                                "${model.selectedDate.year}-${model.selectedDate.month.toString().padLeft(2, '0')}-${model.selectedDate.day.toString().padLeft(2, '0')}",
                            gurdianName: model.gurdian.text,
                            relation: model.reletion.text
                          );
                          navigationService.goBack(result: true);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.sp),
                        height: 55.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.poppins,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTextfileld extends StatelessWidget {
  const CustomTextfileld({
    required this.hintText,
    required this.controller,
    required this.type,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    super.key,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 55.sp,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28), color: Colors.white),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Required field';
              }
              return null;
            },
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: 12.sp,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

Widget selecTingWidget(
    {required RegisterViewmodel model, required BuildContext context}) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      int? selectedIndex = model.classModel?.data
              .indexWhere((item) => item.name == model.institute.text) ??
          -1;
      selectedIndex = selectedIndex != -1 ? selectedIndex : null;

      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Institute',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: model.classModel?.data.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(model.classModel!.data[index].name),
                    trailing: selectedIndex == index
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(
                            Icons.check_box_outline_blank_outlined,
                            color: Colors.black,
                          ),
                    onTap: () {
                      model.institute.text = model.classModel!.data[index].name;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class RegisterViewArguments {
  final String institute;

  RegisterViewArguments(this.institute);
}
