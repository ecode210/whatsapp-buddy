import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_call/viewmodel/crm.dart';

class EditLead extends GetWidget<CRM> {
  EditLead({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                              "Enter Lead",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildTextField(context, size, "Full Name"),
                              buildTextField(context, size, "Phone Number"),
                              buildTextField(context, size, "Email"),
                              buildTextField(context, size, "Address"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: BouncingWidget(
                  onPressed: () {
                    if (validateAndSave()) {
                      controller.savedEvent(context);
                      showGeneralDialog(
                        context: context,
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: false,
                        barrierLabel: '',
                        pageBuilder: (context, animation1, animation2) {
                          return const SizedBox();
                        },
                        barrierColor: Colors.black.withOpacity(0.3),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: size.width * 0.2,
                                    width: size.width * 0.2,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.green.shade100,
                                      color: Colors.green.shade800,
                                      strokeWidth: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  scaleFactor: 1,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    width: size.width * 0.5,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Submit",
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.green.shade800),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context, var size, String title) {
    return Stack(
      children: [
        Container(
          height: 50,
          width: size.width,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green.withOpacity(0.1),
          ),
        ),
        TextFormField(
          keyboardType: title == "Phone Number" ? TextInputType.phone : TextInputType.text,
          initialValue: title == "Email" ? controller.user!.email : null,
          cursorColor: Colors.green.shade800,
          cursorWidth: 2,
          cursorRadius: const Radius.circular(10),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: title,
            hintStyle: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          ),
          onSaved: (value) {
            switch (title) {
              case "Full Name":
                controller.fullName.value = value!;
                break;
              case "Phone Number":
                controller.phoneNumber.value = value!;
                break;
              case "Email":
                controller.email.value = value!;
                break;
              case "Address":
                controller.address.value = value!;
                break;
            }
          },
          validator: (value) {
            switch (title) {
              case "Full Name":
                return errorMessage(value!.contains(" "), "Input valid Full Name");
              case "Phone Number":
                return errorMessage(
                    value!.length >= 7 && value.contains("+"), "Input valid Phone Number with country code");
              case "Email":
                return errorMessage(value!.contains("@"), "Email address is not valid");
              case "Address":
                return errorMessage(value!.length >= 15, "Address too short");
              default:
                return null;
            }
          },
        ),
      ],
    );
  }

  String? errorMessage(bool function, String message) {
    if (function) {
      return null;
    } else {
      Get.snackbar(
        "Invalid Input",
        message,
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green.shade800,
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.green.withOpacity(0.1),
      );
      return "";
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
