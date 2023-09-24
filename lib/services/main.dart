import 'package:firebase_database/firebase_database.dart';

class main_services{
  void set_online(String uid)async{
    await FirebaseDatabase.instance.ref("online-status/$uid").set({
      "online":true,
      "lastseen":""
    });
  }

  void set_offine(String uid)async{
    await FirebaseDatabase.instance.ref("online-status/$uid").set({
      "online":false,
      "lastseen":"${DateTime.now().hour}:${DateTime.now().minute}"
    });
  }
}