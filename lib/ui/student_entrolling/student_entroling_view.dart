import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Hello',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.poppins,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Enroll the Student to the Class",
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: FontFamily.poppins,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 900,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Color(0x14FFFFFF),
                          offset: Offset(-6, -6),
                        ),
                        BoxShadow(
                          blurRadius: 15,
                          color: Color(0x2E000000),
                          offset: Offset(8, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          CustomTextField(
                            hint: 'Class Name',
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
                          const SizedBox(height: 20),
                          model.isBusy
                              ? const  CircularProgressIndicator() 
                              : loginButton(
                                  label: "Enroll",
                                  onPressed: () {
                             
                                    if (model.className.text.isEmpty ||
                                        model.instrectorName.text.isEmpty ||
                                        model.instrectorEmail.text.isEmpty) {
                                    
                                      ScaffoldMessenger.of(context).showSnackBar(
                                     const     SnackBar(
                                          content: Text('All fields must be filled!'),
                                        ),
                                      );
                                    } else {
                                      debugPrint("Button pressed :: Registering instructor...");
                                      model.registerInstructors();
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => StudentEntrolingViewmodel(apiservice: Provider.of(context)),
    );
  }
}
