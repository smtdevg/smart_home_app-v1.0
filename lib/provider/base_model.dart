import 'package:app_smart_home/enum/view_state.dart';
import 'package:flutter/material.dart';
import 'package:app_smart_home/provider/getit.dart';
import 'package:app_smart_home/service/navigation_service.dart';

class BaseModel extends ChangeNotifier {
  final navigationService = getIt.call<NavigationService>;
  ViewState _state = ViewState.idle;

  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
