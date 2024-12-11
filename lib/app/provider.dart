import 'package:karatte_kid/service/apiservice.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentService,
  ...dependServices,
];
List<SingleChildWidget> independentService = [
  ChangeNotifierProvider(
    create: (context) => Apiservice(),
  )
];
List<SingleChildWidget> dependServices = [];
