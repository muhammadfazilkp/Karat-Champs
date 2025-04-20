import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/app/utils.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/register/register_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewmodel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      viewModelBuilder: () =>
          RegisterViewmodel(apiservice: Provider.of(context)),
      builder: (context, model, _) {
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
                onPressed: () {},
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
                      hintText: 'Full name',
                      type: TextInputType.streetAddress,
                      controller: model.fullname,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextfileld(
                      hintText: 'G-mail',
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
                      type: TextInputType.phone,
                      controller: model.phone,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    CustomTextfileld(
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              selecTingWidget(model: model, context: context),
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                        );
                      },
                      hintText: 'Institute',
                      type: TextInputType.streetAddress,
                      controller: model.institute,
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (model.formKey.currentState!.validate()) {
                          model.register(
                              name: model.fullname.text,
                              email: model.email.text,
                              phone: model.phone.text,
                              institute: model.institute.text);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 70.sp),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.poppins,
                                fontSize: 13.sp,
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
    super.key,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 60.sp,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22), color: Colors.white),
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
