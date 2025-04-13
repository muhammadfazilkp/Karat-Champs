import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/pyment_status/pyment_status_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PymentStatusView extends StatelessWidget {
  const PymentStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PymentStatusViewmodel(),
      builder: (context, model, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  navigationService.goBack(result: true);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              backgroundColor: Palete.primaryColor,
              title: Text(
                "Payment Status",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.poppins,
                  fontSize: 18.sp,
                ),
              ),
              bottom:  TabBar(
                unselectedLabelStyle: TextStyle(
                  color: Colors.yellow,
                  fontFamily: FontFamily.poppins
                ),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.poppins
                ),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.white,
                tabs: const    [
                  Tab(text: "Completed"),
                  Tab(text: "Pending"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: const [
                    StudentPaymentCard(
                      name: 'Vivesk Shanker',
                      belt: 'Yellow',
                      date: '27-03-2024',
                    ),
                    StudentPaymentCard(
                      name: 'Anjali Rana',
                      belt: 'Green',
                      date: '15-02-2024',
                    ),
                  ],
                ),

                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: const [
                    StudentPaymentCard(
                      name: 'Rahul Kumar',
                      belt: 'Blue',
                      date: 'Pending',
                    ),
                    StudentPaymentCard(
                      name: 'Nisha Verma',
                      belt: 'Orange',
                      date: 'Pending',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class StudentPaymentCard extends StatelessWidget {
  final String name;
  final String belt;
  final String date;

  const StudentPaymentCard({
    super.key,
    required this.name,
    required this.belt,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Palete.lightGrey,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/profile_new.png'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("Belt: $belt"),
              const SizedBox(height: 4),
              Text("Completed date: $date"),
            ],
          ),
        ],
      ),
    );
  }
}

