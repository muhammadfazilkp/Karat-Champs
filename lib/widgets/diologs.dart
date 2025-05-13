import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/models/belt_model.dart';
import 'package:karatte_kid/service/navigation_srvices.dart';

import '../ui/profile/profile_view_model.dart';

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
              hintStyle: TextStyle(fontSize: 12.sp),
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

Widget selectRelation({
  required List<dynamic> gurdianList,
  required BuildContext context,
  required String title,
  required String? selectedRelation,
  required Function(String) onSelected,
}) {
  return Container(
    height: 400,
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: gurdianList.length,
            itemBuilder: (context, index) {
              final guardian = gurdianList[index];
              final relation = guardian.name ?? '';

              return ListTile(
                title: Text(relation),
                // subtitle: Text(relation),
                trailing: Radio<String>(
                  value: relation,
                  groupValue: selectedRelation,
                  onChanged: (value) {
                    onSelected(value!);
                    Navigator.pop(context);
                  },
                ),
                onTap: () {
                  onSelected(relation);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget logoutDiolog(
    {required ProfileViewModel model, required BuildContext context}) {
  return AlertDialog(
    title: Center(
      child: Text(
        'Logout',
        style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamily.poppins,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp),
      ),
    ),
    content: Text(
      " Do you want Logout ?",
      style: TextStyle(
          color: Colors.black,
          fontFamily: FontFamily.poppins,
          fontWeight: FontWeight.w600,
          fontSize: 15.sp),
      textAlign: TextAlign.center,
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              navigationService.goBack(result: false);
            },
            child: Container(
              height: 45,
              width: 85.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(33),
              ),
              child: Center(
                child: Text(
                  "No",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontFamily.poppins,
                      fontSize: 14.sp),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () {
              model.logout();
            },
            child: Container(
              height: 45,
              width: 85.w,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(33),
              ),
              child: Center(
                child: Text(
                  "Yes",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.poppins,
                      fontSize: 14.sp),
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}
