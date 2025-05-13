import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/ui/bottom_nav/bottomnav_viewmodel.dart';
import 'package:karatte_kid/ui/class_view/class_view.dart';
import 'package:karatte_kid/ui/home/homeview.dart';
import 'package:karatte_kid/ui/profile/profile_view.dart';
import 'package:karatte_kid/ui/search/serchview.dart';
import 'package:stacked/stacked.dart';

class BottomnavView extends StatefulWidget {
  const BottomnavView({super.key});

  @override
  State<BottomnavView> createState() => _BottomnavViewState();
}

class _BottomnavViewState extends State<BottomnavView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomnavViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: [
          const Homeview(),
          const ClassView(),
          const ProfileView()
        ][model.currentIndex],
        bottomNavigationBar: _customBottomNavigationBar(model),
      ),
      viewModelBuilder: () => BottomnavViewmodel(),
    );
  }
}

Widget _customBottomNavigationBar(BottomnavViewmodel model) {
  return Container(
    height: 69.h,
    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kGradients[0],
          _kGradients[1],
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0)),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, -2),
          blurRadius: 6,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child: BottomNavigationBar(
        currentIndex: model.currentIndex,
        onTap: (index) => model.setCurrentIndex(index),
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_2,
              color: Colors.black,
            ),
            label: 'Institutes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings,
              color: Colors.black,
            ),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Palete.primaryColor,
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 8,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 8,
        ),
      ),
    ),
  );
}

const List<Color> _kGradients = [
  Color(0xFFCBCBFE),
  Color(0xFFFFFFFF),
];
