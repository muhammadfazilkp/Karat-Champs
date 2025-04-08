import 'package:flutter/material.dart';
import 'package:karatte_kid/ui/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplsahViewModel>.reactive(
      onViewModelReady: (model) =>model.init(),
      builder: (context, viewModel, _) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.amber,
        );
      },
      viewModelBuilder: () => SplsahViewModel(
        apiservice: Provider.of(context)
      ),
    );
  }
}
