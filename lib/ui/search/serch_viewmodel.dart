import 'package:karatte_kid/service/apiservice.dart';
import 'package:stacked/stacked.dart';

class SerchViewmodel extends BaseViewModel {
  SerchViewmodel({
    required Apiservice apiservice
  }): _apiservice=apiservice;
  final Apiservice _apiservice;
Future<void>init()async{
   _apiservice.getClassDetails();
}
  
}