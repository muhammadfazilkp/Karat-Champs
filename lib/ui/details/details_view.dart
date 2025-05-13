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
            title: const Text('Institute Details'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.studentDetails == null || model.studentDetails!.data == null
                  ? const Center(child: Text('No student details found'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem('Full Name', model.studentDetails!.data!.fullName ?? 'N/A'),
                          _buildDetailItem('Email', model.studentDetails!.data!.email ?? 'N/A'),
                          _buildDetailItem('Phone', model.studentDetails!.data!.phone ?? 'N/A'),
                          _buildDetailItem('Institute', model.studentDetails!.data!.institute ?? 'N/A'),
                          _buildDetailItem('Enrollment Date', model.studentDetails!.data!.enrollmentDate ?? 'N/A'),
                          _buildDetailItem('Registration Date', model.studentDetails!.data!.registrationDate ?? 'N/A'),
                          _buildDetailItem('Belt Change Date', model.studentDetails!.data!.beltChangeDate ?? 'N/A'),
                          _buildDetailItem('Status', (model.studentDetails!.data!.active ?? 0) == 1 ? 'Active' : 'Inactive'),
                        ],
                      ),
                    ),
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}