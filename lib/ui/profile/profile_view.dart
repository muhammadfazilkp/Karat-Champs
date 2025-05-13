import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/profile/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/diologs.dart';

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
              onPressed: model.goHome,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.poppins,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              children: [
                _buildMenuButton(
                  icon: Icons.privacy_tip_outlined,
                  text: 'Privacy Policy',
                  onTap: () {},
                ),
                SizedBox(height: 15.h),
                _buildMenuButton(
                  icon: Icons.info_outline,
                  text: 'About App',
                  onTap: () {},
                ),
                SizedBox(height: 15.h),
                _buildMenuButton(
                  icon: Icons.description_outlined,
                  text: 'Terms & Conditions',
                  onTap: () {},
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return logoutDiolog( context: context, model: model);
                      },);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.poppins,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(
        apiservice: Provider.of(context),
        bottomnavViewmodel: Provider.of(context),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: Palete.primaryColor),
            SizedBox(width: 20.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.poppins,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, size: 24.w, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
