import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_call/view/crm_screen.dart';
import 'package:whatsapp_call/viewmodel/custom_page_builder.dart';
import 'package:whatsapp_call/viewmodel/whatsapp_buddy.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green.shade800,
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
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green.shade800,
                            size: size.width * 0.08,
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
                          Provider.of<Buddy>(context, listen: false).pickContact();
                        },
                        scaleFactor: 0.2,
                        child: Consumer<Buddy>(
                          builder: (context, buddy, child) {
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
Phone
Number""",
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
                      SizedBox(height: size.height * 0.02),
                      CountryCodePicker(
                        onChanged: (value) {
                          Provider.of<Buddy>(context, listen: false).countryCode = value.toString();
                        },
                        initialSelection: 'US',
                        favorite: const ['+1', '+234', '+91'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        barrierColor: Colors.green.shade800,
                        dialogTextStyle: Theme.of(context).textTheme.bodyText1,
                        searchStyle: Theme.of(context).textTheme.bodyText1,
                        showDropDownButton: true,
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        flagWidth: size.width * 0.2,
                      ),
                      SizedBox(height: size.height * 0.02),
                      BouncingWidget(
                        onPressed: () {
                          Provider.of<Buddy>(context, listen: false).launchURL();
                        },
                        scaleFactor: 0.2,
                        child: Consumer<Buddy>(
                          builder: (context, buddy, child) {
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
                        size,
                        FontAwesomeIcons.briefcase,
                        "CRM",
                        const CRMScreen(),
                      ),
                    ),
                    Expanded(
                      child: buildButton(
                        size,
                        FontAwesomeIcons.questionCircle,
                        "FAQ",
                        const CRMScreen(),
                      ),
                    ),
                    Expanded(
                      child: buildButton(
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

  Widget buildButton(var size, IconData icon, String title, Widget child) {
    return BouncingWidget(
      onPressed: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: child,
            direction: AxisDirection.left,
          ),
        );
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
