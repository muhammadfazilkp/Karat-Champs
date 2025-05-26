import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/class_view/class_viewmodel.dart';
import 'package:karatte_kid/ui/details/details_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/model_future_builder.dart';

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
                fontFamily: FontFamily.poppins,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                navigationService.goBack(result: true);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          body: ModelFutureBuilder(
            busy: viewModel.isBusy,
            data: viewModel.classModel,
            loading: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            error: const Center(
              child: Text(
                'No Institute found',
                style: TextStyle(color: Colors.white),
              ),
            ),
            builder: (context, data, _) {
              if (data.data.isEmpty) {
                return const Center(
                  child: Text(
                    'No Institute found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Column(
                children: [
                  SizedBox(height: 10.sp),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.data.length,
                      itemBuilder: (context, index) {
                        final institute = data.data[index];
                        return GestureDetector(
                          onTap: () {
                            viewModel.getInstituteClassDetails(
                                institute: institute.name);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsView(
                                  instituteName: institute.name,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/karete_institute_image.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(38),
                            ),
                            child: Center(
                              child: Text(
                                institute.name,
                                style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontFamily: FontFamily.bigowl,
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      viewModelBuilder: () => ClassViewModel(
        apiservice: Provider.of(context),
      ),
    );
  }
}
