import 'package:stacked/stacked.dart';

class BottomnavViewmodel extends IndexTrackingViewModel {
    int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners(); 
  }
  
}