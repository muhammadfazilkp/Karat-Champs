import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';
import 'package:karatte_kid/ui/home/home_viewmodel.dart';
import 'package:karatte_kid/ui/pyment_status/pyment_status_view.dart';
import 'package:karatte_kid/ui/register/register_view.dart';
import 'package:karatte_kid/widgets/diologs.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      onViewModelReady: (viewmodel) => viewmodel.init(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70.h,
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const  RegisterView(),));
                },
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
                    backgroundImage: AssetImage('assets/images/Mask group.png'),
                    backgroundColor: Colors.teal,
                  ),
                )
              ],
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.3),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hello Instructor",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.white,
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
                            color: const Color.fromARGB(255, 143, 105, 105),
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
                              ),
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 40,
                          ),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return createClassDiolog(
                                context: context,
                              );
                            },
                          );
                        },
                        icon: Icons.people,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      CustomTabView(
                        onTap: () {
                          navigationService.pushNamed(RoutePaths.studentView);
                        },
                        icon: Icons.private_connectivity_outlined,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      CustomTabView(
                        onTap: () {
                          // viewModel.logout();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PymentStatusView(),
                              ));
                        },
                        icon: Icons.wallet,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
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
