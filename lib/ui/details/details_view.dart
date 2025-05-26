import 'package:flutter/material.dart';
import 'package:karatte_kid/ui/details/details_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';



class DetailsView extends StatelessWidget {
  final String instituteName;
  
  const DetailsView({super.key, required this.instituteName});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsViewmodel>.reactive(
      viewModelBuilder: () => DetailsViewmodel(apiservice: Provider.of(context)),
      onViewModelReady: (model) => model.getInstituteClassDetails(institute: instituteName),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Students Details'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body:  model.isBusy
    ? const Center(child: CircularProgressIndicator())
    : model.studentDetails == null || model.studentDetails!.data == null
            ? const Center(child: Text('No student details found'))

                 : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: model.studentDetails!.data!.length,
            itemBuilder: (context, index) {
              final student = model.studentDetails!.data![index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailItem('Full Name', student.fullName ?? 'N/A'),
                      buildDetailItem('Email', student.email ?? 'N/A'),
                      buildDetailItem('Phone', student.phone ?? 'N/A'),
                      buildDetailItem('Institute', student.institute ?? 'N/A'),
                      buildDetailItem('Belt', student.belt?? 'White'),
                        buildDetailItem('Gurdian', student.guardianName?? ''),
                      // _buildDetailItem('Enrollment Date', student.enrollmentDate ?? 'N/A'),
                      buildDetailItem('Registration Date', student.registrationDate ?? 'N/A'),
                      // _buildDetailItem('Belt Change Date', student.beltChangeDate ?? 'N/A'),
                    ],
                  ),
                ),
              );
            }
              )
              )
              ;
            }
        );
      }
    
  }

  Widget buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
