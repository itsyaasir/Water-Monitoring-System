import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:rounded_loading_button/rounded_loading_button.dart";
import "../controllers/login_controller.dart";
import "../../../global_widgets/custom_text_field.dart";

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> saveFormKey = GlobalKey<FormState>();
    return Scaffold(
      // very light grey
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
            key: saveFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey,
                      letterSpacing: 1.0),
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 1.0,
                      color: Colors.grey),
                ),
                const SizedBox(height: 100),
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
                        borderRadius: BorderRadius.circular(16),
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
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RoundedLoadingButton(
                    controller: controller.roundedLoadingButton,
                    color: Colors.black,
                    width: 500,
                    borderRadius: 20,
                    onPressed: () {
                      if (saveFormKey.currentState!.validate()) {
                        controller.validateAndSubmit();
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.offAllNamed("/register"),
                  child: const Center(
                    child: Text(
                      "Create account",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
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
