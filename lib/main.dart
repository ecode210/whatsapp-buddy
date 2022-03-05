import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_call/view/home.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.green.shade800,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WhatsApp Buddy",
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.green.shade800,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          headline2: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          bodyText1: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          bodyText2: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.grey.shade900,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          button: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      home: Home(),
    );
  }
}
