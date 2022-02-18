import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../viewmodel/crm.dart';

class CRMScreen extends StatefulWidget {
  const CRMScreen({Key? key}) : super(key: key);

  @override
  _CRMScreenState createState() => _CRMScreenState();
}

class _CRMScreenState extends State<CRMScreen> {
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
                                Navigator.pop(context);
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
                            const Spacer(),
                            if (Provider.of<CRM>(context).user != null)
                              Consumer<CRM>(
                                builder: (context, crm, child) {
                                  return BouncingWidget(
                                    onPressed: () {
                                      crm.googleLogout();
                                    },
                                    scaleFactor: 0.4,
                                    child: Container(
                                      width: 130,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.logout_rounded,
                                            color: Colors.green.shade800,
                                            size: size.width * 0.06,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "Logout",
                                            style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<CRM>(
                builder: (context, crm, child) {
                  return Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: crm.user != null
                        ? Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: size.width,
                                height: size.height * 0.1,
                              ),
                              Positioned(
                                top: -50,
                                child: CircleAvatar(
                                  radius: size.width * 0.115,
                                  backgroundColor: Colors.green.shade100,
                                  backgroundImage: NetworkImage(crm.user!.photoUrl.toString()),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                child: Text(
                                  crm.user!.displayName.toString(),
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )
                            ],
                          )
                        : BouncingWidget(
                            onPressed: () {
                              crm.googleLogin();
                            },
                            scaleFactor: 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: size.width * 0.06,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "Google Sign-in",
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
