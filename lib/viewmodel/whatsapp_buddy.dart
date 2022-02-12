import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class Buddy extends ChangeNotifier {
  Contact? contact;
  String? name, phone, countryCode;

  Future pickContact() async {
    if (await FlutterContacts.requestPermission()) {
      contact = await FlutterContacts.openExternalPick();
      phone = contact!.phones[0]
          .toString()
          .split("=")[1]
          .split(",")[0]
          .replaceAll(" ", "")
          .replaceAll("-", "");
      print(phone);
      name =
          "${contact!.name.toString().split("=")[1].split(",")[0]} ${contact!.name.toString().split("=")[2].split(",")[0]}";
    }
    notifyListeners();
  }

  void launchURL() async {
    String number = "";
    if (phone!.contains("+")) {
      number = phone!;
    } else {
      number = "$countryCode$phone";
    }
    String url = "https://wa.me/$number";
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
