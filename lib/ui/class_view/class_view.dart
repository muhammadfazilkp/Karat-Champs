import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/class_view/class_viewmodel.dart';
import 'package:karatte_kid/ui/details/details_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassViewModel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.sp,
            backgroundColor: Colors.transparent,
            title: Text(
              "Institute View",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: FontFamily.poppins),
            ),
            leading: IconButton(
              onPressed: () {
                navigationService.goBack(result: true);
              },
              icon: const  Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          body: viewModel.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : viewModel.classModel == null
                  ? const Center(
                      child: Text(
                      'No Institute found',
                      style: TextStyle(color: Colors.white),
                    ))
                  : Column(
                      children: [
                        SizedBox(
                          height: 10.sp,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.classModel!.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  viewModel.getInstituteClassDetails(
                                      institute: viewModel
                                          .classModel!.data[index].name);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsView(
                                          instituteName: viewModel
                                              .classModel!.data[index].name,
                                        ),
                                      ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        viewModel.classModel!.data[index].name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontFamily.poppins,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        );
      },
      viewModelBuilder: () => ClassViewModel(
        apiservice: Provider.of(context),
      ),
    );
  }
}
