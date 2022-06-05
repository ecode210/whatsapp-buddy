import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_call/controller/buddy.dart';
import 'package:whatsapp_call/controller/crm.dart';

import '../model/leads.dart';

class ContactLead extends GetWidget<CRM> {
  final Leads leads;

  const ContactLead({Key? key, required this.leads}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BouncingWidget(
                              onPressed: () {
                                Get.back();
                              },
                              scaleFactor: 0.4,
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: size.width * 0.075,
                                color: Colors.green.shade800,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "Lead",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            padding: EdgeInsets.all(size.height * 0.05),
                            decoration: BoxDecoration(
                              color: Colors.green.shade800,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "${leads.fullName!.split("").first}${leads.fullName!.split(" ")[1].split("").first}",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        leads.fullName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
                      ),
                      Text(
                        leads.email.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
                      ),
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildButtons(context, size, "Call", Icons.phone_rounded),
                          const SizedBox(width: 30),
                          buildButtons(context, size, "Text", Icons.message_rounded),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildButtons(context, size, "Email", Icons.email_rounded),
                          const SizedBox(width: 30),
                          buildButtons(context, size, "GPS", Icons.location_on_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, var size, String title, IconData icon) {
    return BouncingWidget(
      onPressed: () {
        switch (title) {
          case "Call":
            Get.find<Buddy>().launchURL("tel:${leads.phoneNumber}");
            break;
          case "Text":
            Get.find<Buddy>().launchURL("sms:${leads.phoneNumber}");
            break;
          case "Email":
            Get.find<Buddy>().launchURL("mailto:${leads.email}");
            break;
          case "GPS":
            var address = Uri.encodeComponent(leads.address.toString());
            Get.find<Buddy>().launchURL("https://www.google.com/maps/dir/?api=1&destination=$address}");
            break;
        }
      },
      scaleFactor: 1,
      child: Container(
        height: size.height * 0.15,
        width: size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.green.shade800,
              size: size.height * 0.04,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
