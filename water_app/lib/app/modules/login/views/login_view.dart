import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:rounded_loading_button/rounded_loading_button.dart";
import "../controllers/login_controller.dart";
import "../../../global_widgets/custom_text_field.dart";

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> saveFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100.0,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Form(
            key: saveFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  name: "E-mail",
                  controller: controller.email,
                  validator: (email) => (!email!.trim().contains("@"))
                      ? "Please enter a valid email address"
                      : null,
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.blue[50],
                      filled: true,
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
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
                  ),
                ),

                // Eye

                const SizedBox(height: 20),
                Center(
                  child: RoundedLoadingButton(
                    controller: controller.roundedLoadingButtonOne,
                    onPressed: () {
                      if (saveFormKey.currentState!.validate()) {
                        controller.validateAndSubmit();
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => {
                    Get.dialog(
                      Material(
                        child: Center(
                          child: Container(
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text("Enter your Email"),
                                  CustomTextField(
                                    name: "E-mail",
                                    controller: controller.email,
                                    validator: (email) => (!email!
                                            .trim()
                                            .contains("@"))
                                        ? "Please enter a valid email address"
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  },
                  child: const Text(
                    "Forgot Password ?",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.offAllNamed("/register"),
                  child: const Text(
                    "Don't have an account ? Click here",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
