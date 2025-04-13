import 'package:stacked/stacked.dart';

class PymentStatusViewmodel extends BaseViewModel {
   bool isCompletedSelected = true;

  void setStatus(bool isCompleted) {
    isCompletedSelected = isCompleted;
    notifyListeners();
  }

}