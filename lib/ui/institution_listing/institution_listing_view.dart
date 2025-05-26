import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/ui/institution_listing/institution_listing_viewmodel.dart';
import 'package:karatte_kid/ui/pre_register/pre_register_view.dart';
import 'package:karatte_kid/widgets/model_future_builder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../constant/app_constant.dart';

class InstitutionListingView extends StatelessWidget {
  const InstitutionListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (model) => model.getClassDetails(),
      viewModelBuilder: () =>
          InstitutionListingViewmodel(apiservice: Provider.of(context)),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            "Select the institute",
            style: TextStyle(
                color: Colors.black,
                fontFamily: FontFamily.poppins,
                fontSize: 14.sp),
          )),
          body: ModelFutureBuilder(
            busy: model.isBusy,
            data: model.classModel,
            builder: (context, value, _) {
              if (value.data.isEmpty) {
                return const Center(
                  child: Text('No Institutes Found'),
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 13.sp,
                  ),
                  // Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       'Select Institute',
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontFamily: FontFamily.poppins),
                  //       textAlign: TextAlign.start,
                  //     )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                        itemCount: value.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.4,
                        ),
                        itemBuilder: (context, index) {
                          final institute = value.data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreRegisterView(
                                      instituteName: institute.name,
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Palete.lightGrey,
                              ),
                              child: Center(
                                child: Text(
                                  institute.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
