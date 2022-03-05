import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_call/view/enter_lead.dart';
import 'package:whatsapp_call/view/view_lead.dart';

class CRMScreen extends StatelessWidget {
  const CRMScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        "CRM",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                BouncingWidget(
                  onPressed: () {
                    Get.to(() => EditLead());
                  },
                  scaleFactor: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.green.shade800,
                    radius: size.width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_rounded,
                          color: Colors.white,
                          size: size.width * 0.1,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: size.width * 0.3,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Enter Lead",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                BouncingWidget(
                  onPressed: () {
                    Get.to(() => const ViewLead());
                  },
                  scaleFactor: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.green.shade800,
                    radius: size.width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.white,
                          size: size.width * 0.1,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: size.width * 0.3,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "View Lead",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
