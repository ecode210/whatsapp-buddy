import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Buddy extends GetxController {
  PhoneContact? contact;
  String? name, phone, countryCode;

  Future pickContact() async {
    if (await FlutterContactPicker.requestPermission()) {
      contact = await FlutterContactPicker.pickPhoneContact();
      phone = contact!.phoneNumber!.number;
      name = contact!.fullName;
    }
    update();
  }

  void launchCustomURL() async {
    String number = "";
    if (phone!.contains("+")) {
      number = phone!;
    } else {
      number = "$countryCode$phone";
    }
    String url = "https://wa.me/$number";
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
