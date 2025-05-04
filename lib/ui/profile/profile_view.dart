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
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Palete.primaryColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                // debugPrint("Button Press..");
                model.goHome();
              },
            ),
            title: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.poppins,
                ),
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),

                Container(
                  height: 120.w,
                  width: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palete.lightGrey,
                    border: Border.all(
                      color: Palete.primaryColor,
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50.w,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.poppins,
                  ),
                ),

                SizedBox(height: 30.h),

                // Section Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'General Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.poppins,
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                // Details List
                Column(
                  children: [
                    const DetailWidget(
                      icon: Icons.person_outline,
                      text: 'Instructor: Master Chen',
                    ),
                    SizedBox(height: 10.h),
                    const DetailWidget(
                      icon: Icons.cake_outlined,
                      text: 'Age: 13 years',
                    ),
                    SizedBox(height: 10.h),
                    const DetailWidget(
                      icon: Icons.transgender,
                      text: 'Gender: Male',
                    ),
                    SizedBox(height: 10.h),
                    const DetailWidget(
                      icon: Icons.phone,
                      text: 'Contact: +1 234 567 890',
                    ),
                    SizedBox(height: 10.h),
                    const DetailWidget(
                      icon: Icons.workspace_premium,
                      text: 'Belt: Red',
                      iconColor: Colors.red,
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                SizedBox(
                  width: 150.w,
                  child: ElevatedButton(
                    onPressed: model.logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palete.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: FontFamily.poppins,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(
          apiservice: Provider.of(context),
          bottomnavViewmodel: Provider.of(context)),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;

  const DetailWidget({
    required this.text,
    required this.icon,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Palete.lightGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? Palete.black,
            size: 22.w,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: FontFamily.poppins,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
