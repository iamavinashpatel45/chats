import 'package:chats/home/chat/services/contact_modul.dart';
import 'package:chats/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_number/phone_number.dart';

class contacts_service {
  List<Contact> contacts = [];
  List<contacts_modul> contact_modul = [];
  final stores = FirebaseFirestore.instance;
  final box = GetStorage();

  Future<bool> get_contacts() async {
    contacts = await FastContacts.getAllContacts();
    QuerySnapshot _querysnapshort = await stores.collection('numbers').get();
    for (var element in _querysnapshort.docs) {
      String s1 = await PhoneNumberUtil().format(element.id, "IN");
      for (int i = 0; i < contacts.length; i++) {
        if (contacts[i].phones.isNotEmpty) {
          String s2 = await PhoneNumberUtil()
              .format(contacts[i].phones[0].number, "IN");
          if (s1 == s2) {
            contact_modul.add(
              contacts_modul(
                name: contacts[i].displayName,
                num: s2,
                id: element.get("uid"),
                image: element.get("image")
              ),
            );
            break;
          }
        }
      }
    }
    local_data.contact = contact_modul;
    box.write("contact", contact_modul);
    return true;
  }
}
