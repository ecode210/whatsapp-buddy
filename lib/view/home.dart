import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whatsapp_call/controller/buddy.dart';
import 'package:whatsapp_call/view/crm_screen.dart';

import '../controller/crm.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final buddyController = Get.put(Buddy());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                width: size.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/crm.svg",
                            height: size.width * 0.07,
                            width: size.width * 0.07,
                            color: Colors.green.shade800,
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: size.width * 0.5,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "WhatsApp Buddy",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      const Divider(
                        color: Colors.green,
                        thickness: 2,
                      ),
                      const Spacer(),
                      BouncingWidget(
                        onPressed: () {
                          buddyController.pickContact();
                        },
                        scaleFactor: 0.2,
                        child: GetBuilder<Buddy>(
                          builder: (buddy) {
                            return Container(
                              height: size.height * 0.17,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.green.shade800,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: buddy.contact == null
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.phoneAlt,
                                          color: Colors.white,
                                          size: size.width * 0.1,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          """
Pick
Contact""",
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: size.width * 0.5,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          """
${buddy.name}
${buddy.phone}""",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                      CountryCodePicker(
                        onChanged: (value) {
                          buddyController.countryCode = value.toString();
                        },
                        initialSelection: 'US',
                        favorite: const ['US', '+234', '+91', '+380'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        barrierColor: Colors.green.shade800,
                        dialogTextStyle: Theme.of(context).textTheme.bodyText1,
                        searchStyle: Theme.of(context).textTheme.bodyText1,
                        showDropDownButton: true,
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        flagWidth: size.width * 0.2,
                      ),
                      BouncingWidget(
                        onPressed: () {
                          buddyController.launchCustomURL();
                        },
                        scaleFactor: 0.2,
                        child: GetBuilder<Buddy>(
                          builder: (buddy) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: size.height * 0.17,
                              width: size.width * 0.6,
                              decoration: BoxDecoration(
                                color: buddy.name == null && buddy.countryCode == null
                                    ? Colors.green.shade200
                                    : Colors.green.shade800,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: buddy.name == null && buddy.countryCode == null
                                        ? Colors.green.shade100
                                        : Colors.green.withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.white,
                                    size: size.width * 0.1,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    """
WhatsApp
Number""",
                                    style: Theme.of(context).textTheme.headline2,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      const Divider(
                        color: Colors.green,
                        thickness: 2,
                      ),
                      const Spacer(),
                      GetBuilder<CRM>(
                        init: CRM(),
                        builder: (crm) {
                          return BouncingWidget(
                            onPressed: () {
                              crm.user != null ? crm.googleLogout() : crm.googleLogin();
                            },
                            scaleFactor: 0.4,
                            child: Container(
                              width: size.width * 0.6,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.green.shade800,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: crm.user != null
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.logout_rounded,
                                          color: Colors.white,
                                          size: size.width * 0.06,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Logout",
                                          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.google,
                                          color: Colors.white,
                                          size: size.width * 0.06,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Login via Google",
                                          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      BouncingWidget(
                        onPressed: () {
                          Get.generalDialog(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return const SizedBox();
                            },
                            barrierColor: Colors.black.withOpacity(0.3),
                            barrierDismissible: true,
                            barrierLabel: '',
                            transitionDuration: const Duration(milliseconds: 200),
                            transitionBuilder: (context, animation, secondaryAnimation, child) {
                              return Transform.scale(
                                scale: animation.value,
                                child: Opacity(
                                  opacity: animation.value,
                                  child: Dialog(
                                    backgroundColor: Colors.white,
                                    alignment: Alignment.center,
                                    elevation: 0,
                                    child: Container(
                                      height: size.height * 0.2,
                                      width: 0,
                                      padding: const EdgeInsets.symmetric(horizontal: 50),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: BouncingWidget(
                                              onPressed: () {
                                                buddyController.launchURL("https://wa.me/+17275658954");
                                              },
                                              scaleFactor: 1,
                                              child: const FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text("🇺🇸"),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 50),
                                          Expanded(
                                            child: BouncingWidget(
                                              onPressed: () {
                                                buddyController.launchURL("https://wa.me/+2348138313912");
                                              },
                                              scaleFactor: 1,
                                              child: const FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text("🇳🇬"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        scaleFactor: 0.4,
                        child: Column(
                          children: [
                            Text(
                              "Contact Developer - Cal Tiger",
                              style: Theme.of(context).textTheme.button!.copyWith(color: Colors.green.shade800),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green.shade800,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "+1 727 565 8954 🇺🇸",
                                  style: Theme.of(context).textTheme.button!.copyWith(color: Colors.green.shade800),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green.shade800,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "+234 813 831 3912 🇳🇬",
                                  style: Theme.of(context).textTheme.button!.copyWith(color: Colors.green.shade800),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: buildButton(
                        context,
                        size,
                        FontAwesomeIcons.briefcase,
                        "CRM",
                        const CRMScreen(),
                      ),
                    ),
                    Expanded(
                      child: buildButton(
                        context,
                        size,
                        FontAwesomeIcons.questionCircle,
                        "FAQ",
                        const CRMScreen(),
                      ),
                    ),
                    Expanded(
                      child: buildButton(
                        context,
                        size,
                        FontAwesomeIcons.phoneSquareAlt,
                        "CONTACT",
                        const CRMScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, var size, IconData icon, String title, Widget child) {
    return BouncingWidget(
      onPressed: () {
        if (Get.find<CRM>().user != null) {
          Get.to(() => child);
        } else {
          Get.defaultDialog(
            middleText: """
Please Sign-In to access the CRM""",
            contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            titleStyle: Theme.of(context).textTheme.headline1,
            middleTextStyle: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.grey.shade900,
                  fontSize: 15,
                ),
          );
        }
      },
      scaleFactor: 0.4,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              size: size.width * 0.06,
              color: Colors.white,
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.button,
            )
          ],
        ),
      ),
    );
  }
}
