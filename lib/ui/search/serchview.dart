import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karatte_kid/constant/app_color.dart';
import 'package:karatte_kid/constant/app_constant.dart';
import 'package:karatte_kid/ui/search/serch_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SerchViewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, _) {

        
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sh),
                      color: Palete.lightGrey,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            size: 20,
                            color: Color.fromARGB(255, 34, 33, 33),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          hintText: 'Search..',
                          hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromARGB(96, 62, 62, 62),
                              fontFamily: FontFamily.poppins),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SerchViewmodel(apiservice: Provider.of(context)),
    );
  }
}
