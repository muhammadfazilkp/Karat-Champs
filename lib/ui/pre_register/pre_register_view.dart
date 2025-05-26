import 'package:flutter/material.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/pre_register/pre_register_viewmodel.dart';
import 'package:karatte_kid/ui/register/register_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../details/details_view.dart';

class PreRegisterView extends StatelessWidget {
  const PreRegisterView({required this.instituteName, super.key});
  final String? instituteName;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.getInstituteClassDetails(
          institute: instituteName.toString()),
      viewModelBuilder: () =>
          PreRegisterViewmodel(apiservice: Provider.of(context)),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Register your Student",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: FontFamily.poppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegisterView(institute: instituteName),
                  ));
            },
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final student = model.studentDetails!.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDetailItem(
                                  'Full Name', student.fullName ?? 'N/A'),
                              buildDetailItem('Email', student.email ?? 'N/A'),
                              buildDetailItem('Phone', student.phone ?? 'N/A'),
                              buildDetailItem(
                                  'Institute', student.institute ?? 'N/A'),
                              buildDetailItem('Belt', student.belt ?? 'White'),
                              buildDetailItem(
                                  'Gurdian', student.guardianName ?? ''),
                              // _buildDetailItem('Enrollment Date', student.enrollmentDate ?? 'N/A'),
                              buildDetailItem('Registration Date',
                                  student.registrationDate ?? 'N/A'),
                              // _buildDetailItem('Belt Change Date', student.beltChangeDate ?? 'N/A'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: model.studentDetails?.data?.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
