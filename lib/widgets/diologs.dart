import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';

Widget customDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String buttonText,
  VoidCallback? onPressed,
}) {
  return AlertDialog(
    title: Center(
        child: Text(
      title,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
          fontFamily: FontFamily.poppins,
          fontWeight: FontWeight.w400),
      maxLines: 2,
      textAlign: TextAlign.center,
    )),
    content: Text(
      content,
      style: TextStyle(
          color: Colors.white,
          fontFamily: FontFamily.poppins,
          fontWeight: FontWeight.w700),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Text(buttonText),
      ),
    ],
  );
}

Widget createClassDiolog({
  required BuildContext context,
}) {
  return AlertDialog(
    title: Center(
      child: Text(
        'Create Class',
        style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.w500),
      ),
    ),
    content: Container(
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Class Name',
              hintStyle: TextStyle(
                fontSize: 12.sp
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  navigationService.goBack(result: false);
                },
                child: Container(
                  height: 40,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color.fromARGB(255, 92, 92, 96)),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontFamily: FontFamily.poppins,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 13.w,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Palete.primaryColor),
                  child: Center(
                    child: Text(
                      'Create',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontFamily: FontFamily.poppins,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
