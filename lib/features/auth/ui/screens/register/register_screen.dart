import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/constants/app_constants.dart';
import 'package:movies/core/utils/app_dialogs.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_carousel_slider.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isObscure = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomCarouselSlider(
                  length: AppConstants.avatars.length,
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return Image.asset(
                      AppConstants.avatars[itemIndex],
                      fit: .contain,
                    );
                  },
                ),
                CustomTextField(
                  hintText: "Name",
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconIdentification),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: emailCtrl,
                  hintText: "Email",
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconEmail),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: "Password",
                  isObscure: isObscure,
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconLock),
                    color: Colors.white,
                  ),
                  suffixIcon: ImageIcon(
                    AssetImage(AppAssets.iconEyeOff),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  hintText: "Confirm Password",
                  isObscure: isObscure,
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconLock),
                    color: Colors.white,
                  ),
                  suffixIcon: ImageIcon(
                    AssetImage(AppAssets.iconEyeOff),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: "Phone Number",
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconCall),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.height * .024),
                buildCreateAccountButton(),
                SizedBox(height: context.height * .02),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Already Have Account ? ",
                      style: context.textTheme.bodySmall,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, AppRoutes.loginScreen);
                      },
                      child: Text(
                        "Login",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.lightOrange,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * .025),

                Switch(
                  trackOutlineColor: WidgetStatePropertyAll(
                    AppColors.lightOrange,
                  ),
                  inactiveTrackColor: Colors.transparent,
                  inactiveThumbColor: AppColors.lightOrange,
                  activeTrackColor: Colors.transparent,
                  activeThumbColor: AppColors.lightOrange,
                  activeThumbImage: AssetImage(AppAssets.iconEgypt),
                  inactiveThumbImage: AssetImage(AppAssets.iconUS),
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCreateAccountButton() {
    return CustomButton(
      text: "Create Account",
      onPress: () async {
        try {
          showLoading(context);
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: emailCtrl.text,
                password: passwordCtrl.text,
              );

          Navigator.pop(context);
          Navigator.push(context, AppRoutes.navigationScreen);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          var message = "";
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            message = 'The account already exists for that email.';
          } else {
            message = e.message ?? AppConstants.defaultErrorMessage;
          }
          showMessage(context, message, title: "Error!", posText: "Ok");
        } catch (e) {
          showMessage(
            context,
            AppConstants.defaultErrorMessage,
            title: "Error!",
            posText: "Ok",
          );
        }
      },
    );
  }
}

