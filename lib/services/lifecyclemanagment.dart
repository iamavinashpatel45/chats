import 'package:chats/local_data.dart';
import 'package:chats/services/main.dart';
import 'package:flutter/widgets.dart';

class MyAppLifecycleObserver extends WidgetsBindingObserver {
  final main_services _main_services = main_services();
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("state changed");
    print(state.toString());
    if (state == AppLifecycleState.paused) {
      _main_services.set_offine(local_data.uid!);
    } else if (state == AppLifecycleState.resumed) {
      _main_services.set_online(local_data.uid!);
    }
  }
}
