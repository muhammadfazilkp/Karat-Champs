import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/profile/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.maxFinite,
                  color: Palete.primaryColor,
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 176, 169, 169),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 120,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomProfileWidget(
                                icon: Icons.trip_origin_sharp,
                                onPressed: () {}),
                            CustomProfileWidget(
                                icon: Icons.wallet, onPressed: () {}),
                            CustomProfileWidget(
                                icon: Icons.file_copy_sharp, onPressed: () {}),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'General',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: FontFamily.poppins,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const DetailWidget(text: 'Instrector Name: Hello'),
                      const SizedBox(height: 10),
                      const DetailWidget(text: 'Age : 13'),
                      const SizedBox(height: 10),
                      const DetailWidget(text: 'Gender : Male'),
                      const SizedBox(height: 10),
                      const DetailWidget(text: 'Contact Number : 23456789'),
                      const SizedBox(height: 10),
                      const DetailWidget(text: 'Belt : Red'),
                      const SizedBox(height: 20),
                         GestureDetector(
                  onTap: () {
                    model.logout();
                  },
                  child: Container(
                    height: 45.h,
                    width: 125.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Palete.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white,
                        fontFamily: FontFamily.poppins,
                        fontSize: 13),
                      ),
                    ),
                  
                  ),
                ),

                 const SizedBox(height: 30)
                    ],
                  ),
                ),
             
                  const SizedBox(height: 30)
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(
        apiservice: Provider.of(context)
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(
        color: Palete.lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: FontFamily.poppins,
                    fontSize: 15.sp),
                textAlign: TextAlign.start,
              ),
            )),
      ),
    );
  }
}

class CustomProfileWidget extends StatelessWidget {
  const CustomProfileWidget({
    required this.icon,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Icon(icon),
      ),
    );
  }
}
