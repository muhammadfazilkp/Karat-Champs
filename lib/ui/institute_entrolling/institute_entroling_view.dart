import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/login/loginview.dart';
import 'package:karatte_kid/ui/institute_entrolling/institute_entroling_viewmodel.dart';
import 'package:karatte_kid/widgets/custome_textform_feild.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class StudentEntrolingView extends StatelessWidget {
  const StudentEntrolingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentEnrollingViewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.sp,
            backgroundColor: Colors.transparent,
            
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
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Center(
                          child: Image(
                        image: AssetImage('assets/images/Vector.png'),
                        height: 130,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   'Hello',
                      //   style: TextStyle(
                      //     fontSize: 24.sp,
                      //     fontWeight: FontWeight.w600,
                      //     fontFamily: FontFamily.poppins,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      Text(
                        "Enroll the Institute",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
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
                              controller: model.instructorEmail,
                              focusNode: FocusNode(),
                              textInputType: TextInputType.emailAddress,
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
                            const SizedBox(height: 15),
                            Container(
                              height: 120.h,
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12.4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Add your  address....',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                maxLines: 4,
                              ),
                            ),

                            // CustomTextField(
                            //   hint: 'Instructor adrres',
                            //   top: 1,
                            //   controller: model.address,
                            //   focusNode: FocusNode(),
                            //   textInputType: TextInputType.name,
                            //   onSaved: (newValue) {},
                            // ),

                            const SizedBox(height: 20),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: loginButton(
                                label: "Enroll",
                                onPressed: () {
                                  model.registerInstructors(context);
                                  navigationService.goBack(result: true);
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
          StudentEnrollingViewmodel(apiservice: Provider.of(context)),
    );
  }
}
