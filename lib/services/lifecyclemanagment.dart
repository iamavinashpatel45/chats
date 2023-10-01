import 'package:chats/services/local_data.dart';
import 'package:chats/services/main_services.dart';
import 'package:flutter/widgets.dart';

class MyAppLifecycleObserver extends WidgetsBindingObserver {
  final MainServices _mainServices = MainServices();
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _mainServices.setOffine(LocalData.uid!);
    } else if (state == AppLifecycleState.resumed) {
      _mainServices.setOnline(LocalData.uid!);
    }
  }
}
