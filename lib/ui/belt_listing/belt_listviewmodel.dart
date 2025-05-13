import 'package:stacked/stacked.dart';

import '../../models/belt_model.dart';
import '../../service/apiservice.dart';

class BeltListviewmodel extends BaseViewModel {
  BeltListviewmodel({
    required Apiservice apiservice,
  }) : _apiservice = apiservice;
  final Apiservice _apiservice;

  var beltList = List<BeltModel>;
  BeltModel? beltModel;

  Future<void> init() async {
    beltModel = await runBusyFuture(_apiservice.getBelt());
  }
}
