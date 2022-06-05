import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_call/controller/crm.dart';
import 'package:whatsapp_call/model/leads.dart';
import 'package:whatsapp_call/view/contact_lead.dart';

class ViewLead extends GetWidget<CRM> {
  const ViewLead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Container(
          width: size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
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
                        "View Lead",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.firestore.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index) {
                            dynamic data = snapshot.data!.docs[index].data();
                            return buildList(context, size, data);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.redAccent,
                            size: size.width * 0.2,
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.green.shade800,
                            backgroundColor: Colors.green.shade100,
                            strokeWidth: 10,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, var size, dynamic data) {
    Leads leads = Leads.fromJson(data);
    return BouncingWidget(
      onPressed: () {
        Get.to(() => ContactLead(leads: leads));
      },
      scaleFactor: 1,
      child: Container(
        height: size.height * 0.1,
        width: size.width,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade800,
              radius: size.height * 0.04,
              child: SizedBox(
                height: size.height * 0.04,
                width: size.height * 0.04,
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
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leads.fullName.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
                  ),
                  Text(
                    leads.email.toString(),
                    style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 13),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
