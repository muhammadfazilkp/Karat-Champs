import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/home/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';


class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      onViewModelReady: (viewmodel) => viewmodel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  AppBar(
                    toolbarHeight: 70.h,
                    leading: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.menu,
                        color: const Color.fromARGB(255, 184, 177, 177),
                        size: 35.sp,
                      ),
                    ),
                    actions: const [
                      Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/Mask group.png'),
                          backgroundColor: Colors.teal,
                        ),
                      )
                    ],
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.3),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          // navigationService
                          //     .pushNamed(RoutePaths.studentListView);
                        },
                        child: Text(
                          "Hello ${viewModel.user?.firstName}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 13),
                        height: 145.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 145, 147, 154),
                              Color.fromARGB(255, 178, 178, 189),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 90, left: 13),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Welcome to the Dashboard \n Unleash your inner warrior and take your training to the next level. Track your progress, master new techniques',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -50,
                        right: 10,
                        child: Image.asset(
                          'assets/images/Vector.png',
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 37),
                      child: Text(
                        "ACADEMICS",
                        style: TextStyle(
                          fontFamily: FontFamily.poppins,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTabView(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return createClassDiolog(
                          //       context: context,
                          //     );
                          //   },
                          // );
                          navigationService
                              .pushNamed(RoutePaths.studentListView);
                        },
                        icon: Icons.people,
                      ),
                      const SizedBox(width: 25),
                      CustomTabView(
                        onTap: () {
                          // navigationService.pushNamed(RoutePaths.studentView);
                        },
                        icon: Icons.workspace_premium,
                      ),
                      const SizedBox(width: 25),
                      CustomTabView(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const PymentStatusView(),
                          //   ),
                          // );
                        },
                        icon: Icons.account_balance_wallet,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  viewModel.user?.isAdmin == true
                      ? Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10,),
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // blurRadius: 1,
                                offset: const Offset(0, 3),
                                color: Colors.grey.withOpacity(0.3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(1),
                            color: Colors.white),
                        child: TextButton.icon(
                          icon: const Icon(Icons.person_add),
                          onPressed: () {
                            navigationService.pushNamed(
                                RoutePaths.studentRegistrationView);
                          },
                          label: Text(
                            "Add Instrector",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.poppins,
                                fontSize: 9),
                          ),
                        ),
                      )
                      : Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10,),
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // blurRadius: 1,
                                offset: const Offset(0, 3),
                                color: Colors.grey.withOpacity(0.3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(1),
                            color: Colors.white),
                        child: TextButton.icon(
                          icon: const Icon(Icons.person_add),
                          onPressed: () {
                            navigationService.pushNamed(
                                RoutePaths.studentView);
                          },
                          label: Text(
                            "Entroll Student",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.poppins,
                                fontSize: 9),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewmodel(apiservice: Provider.of(context)),
    );
  }
}

class CustomTabView extends StatelessWidget {
  const CustomTabView({
    super.key,
    required this.onTap,
    required this.icon,
  });
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            offset: Offset(4, 4),
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0.2,
          ),
          BoxShadow(
            color: Colors.transparent,
            offset: Offset(4, 4),
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0.2,
          )
        ], borderRadius: BorderRadius.circular(19), color: Colors.white),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
            size: 40.sp,
          ),
        ),
      ),
    );
  }
}




// class DataItem {
//   int x;
//   double y1;
//   double y2;
//   double y3;
//   DataItem(
//       {required this.x, required this.y1, required this.y2, required this.y3});
// }
// class GraphPage extends StatelessWidget {
//     GraphPage({super.key});
//   // Generate dummy data to feed the chart
//   final List<DataItem> _myData = List.generate(
//       30,
//       (index) => DataItem(
//             x: index,
//             y1: index.toDouble(),
//             y2: (index * 2).toDouble(),
//             y3: (index * 3).toDouble(),
//           ));
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('KindaCode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30),
//         child: BarChart(BarChartData(
//             borderData: FlBorderData(
//                 border: const Border(
//               top: BorderSide.none,
//               right: BorderSide.none,
//               left: BorderSide(width: 1),
//               bottom: BorderSide(width: 1),
//             )),
//             groupsSpace: 10,
//             barGroups: [
//                 BarChartGroupData(x: 1, barRods: [
//                 BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 2, barRods: [
//                 BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 3, barRods: [
//                 BarChartRodData(fromY: 0, toY: 15, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 4, barRods: [
//                 BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 5, barRods: [
//                 BarChartRodData(fromY: 0, toY: 11, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 6, barRods: [
//                 BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 7, barRods: [
//                 BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//                 BarChartGroupData(x: 8, barRods: [
//                 BarChartRodData(fromY: 0, toY: 10, width: 15, color: Colors.amber),
//               ]),
//             ])),
//             ),
//         );
//     }
// }