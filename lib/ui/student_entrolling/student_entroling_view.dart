import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/login/loginview.dart';
import 'package:karatte_kid/ui/student_entrolling/student_entroling_viewmodel.dart';
import 'package:karatte_kid/widgets/custome_textform_feild.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';


class StudentEntrolingView extends StatelessWidget {
  const StudentEntrolingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentEntrolingViewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Enroll the Institute",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.poppins,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Color(0x14000000),
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CustomTextField(
                              hint: 'Institute Name',
                              controller: model.className,
                              top: 1,
                              focusNode: FocusNode(),
                              textInputType: TextInputType.streetAddress,
                              onSaved: (newValue) {},
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hint: 'Instructor Email',
                              top: 1,
                              controller: model.instrectorEmail,
                              focusNode: FocusNode(),
                              textInputType: TextInputType.emailAddress,
                              onSaved: (newValue) {},
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hint: 'Instructor Name',
                              top: 1,
                              controller: model.instrectorName,
                              focusNode: FocusNode(),
                              textInputType: TextInputType.name,
                              onSaved: (newValue) {},
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hint: 'Phone number',
                              top: 1,
                              controller: model.phone,
                              focusNode: FocusNode(),
                              textInputType: TextInputType.phone,
                              onSaved: (newValue) {},
                            ),
                            const SizedBox(height: 20),
                            model.isBusy
                                ? const CircularProgressIndicator()
                                : Align(
                                  alignment: Alignment.bottomCenter,
                                  child: loginButton(
                                      label: "Enroll",
                                      onPressed: () {
                                        if (model.className.text.isEmpty ||
                                            model.instrectorName.text.isEmpty ||
                                            model.instrectorEmail.text.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('All fields must be filled!'),
                                            ),
                                          );
                                        } else {
                                          model.registerInstructors();
                                          navigationService.goBack(result: true);
                                        }
                                      },
                                    ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () =>
          StudentEntrolingViewmodel(apiservice: Provider.of(context)),
    );
  }
}
