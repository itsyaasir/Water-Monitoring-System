import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../global_widgets/custom_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100.0,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Form(
            key: controller.saveFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Hi! there",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey,
                      letterSpacing: 1.0),
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 1.0,
                      color: Colors.grey),
                ),
                const SizedBox(height: 80),
                CustomTextField(
                  name: "First Name",
                  controller: controller.firstName,
                  validator: (name) => (name!.trim().isEmpty)
                      ? "Please enter your first name"
                      : null,
                ),
                CustomTextField(
                  name: "Last Name",
                  controller: controller.lastName,
                  validator: (name) => (name!.trim().isEmpty)
                      ? "Please enter your last name"
                      : null,
                ),
                CustomTextField(
                  name: "E-mail",
                  controller: controller.email,
                  validator: (email) => (!email!.trim().contains("@"))
                      ? "Please enter a valid email address"
                      : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Obx(() => TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          contentPadding: const EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          fillColor: Colors.white54,
                          filled: true,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              controller.isTapped = !controller.isTapped;
                            },
                          ),
                        ),
                        controller: controller.password,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        validator: (password) => (password!.trim().length < 6)
                            ? "Password must be at least 6 characters long"
                            : null,
                        textCapitalization: TextCapitalization.words,
                        obscureText: controller.isTapped,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      fillColor: Colors.white54,
                      filled: true,
                      hintText: "Confirm Password",
                    ),
                    controller: controller.confirmPassword,
                    keyboardType: TextInputType.text,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    validator: (password) =>
                        (password! != controller.password.text.trim())
                            ? "Password does not match"
                            : null,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RoundedLoadingButton(
                    color: Colors.black,
                    width: 500,
                    borderRadius: 20,
                    controller: controller.loadingButtonController,
                    onPressed: controller.validateAndSave,
                    child: const Text("Register"),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.offAllNamed("/login"),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
