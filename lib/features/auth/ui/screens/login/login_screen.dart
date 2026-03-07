
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/constants/app_constants.dart';
import 'package:movies/core/utils/app_dialogs.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isObscure = true;
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                      AppAssets.movieLogo,
                    height: context.height*.13,
                  ),
                  SizedBox(height:context.height*.07),
                  CustomTextField(
                    controller: emailCtrl,
                    hintText: "Email",
                    prefixIcon: Image.asset(AppAssets.iconEmail),
                  ),
                  SizedBox(height: context.height * .024),
                  CustomTextField(
                    controller: passwordCtrl,
                    hintText: "Password",
                    isObscure: isObscure,
                    prefixIcon: Image.asset(AppAssets.iconLock),
                    suffixIcon: Image.asset(AppAssets.iconEyeOff),
                  ),
                  SizedBox(height: context.height * .018),
                  InkWell(
                    onTap: () {

                    },
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),

                    child: Text(
                     "Forget Password ?",
                      style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.lightOrange,
                    ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                SizedBox(height: context.height * .035),
                  buildLoginButton(),
                  SizedBox(height: context.height * .024),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Don’t Have Account ? ",
                        style: context.textTheme.bodySmall,
                      ),
                      InkWell(
                        onTap: () {
                       Navigator.push(context, AppRoutes.registerScreen);
                        },
                        child: Text(
                          "Create One",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.lightOrange,
                            fontWeight: FontWeight.w900
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.height * .028),
                  Text(
                    "Or",
                    style: context.textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * .028),
                  buildGoogleLoginButton(),
                  SizedBox(height: context.height * .036),
                  Switch(
                    trackOutlineColor: WidgetStatePropertyAll(AppColors.lightOrange),
                    inactiveTrackColor: Colors.transparent,
                    inactiveThumbColor:AppColors.lightOrange,
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
      ),
    );
  }


  Widget buildLoginButton() {
    return CustomButton(
      text: "Login",
      onPress: ()async {

        try {
          showLoading(context);
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailCtrl.text,
              password: passwordCtrl.text
          );
          Navigator.pop(context);
          Navigator.push(context, AppRoutes.navigationScreen);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          var message = "";
          if (e.code == 'user-not-found') {
            message = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            message = 'Wrong password provided for that user.';
          } else {
            message = e.message ?? AppConstants.defaultErrorMessage;
          }
          showMessage(context, message, title: "Error!", posText: "Ok");
        }
      },
    );
  }
  CustomButton buildGoogleLoginButton() {
    return CustomButton(
      onPress: (){

      },
      text: 'Login With Google',
      icon: Image.asset(AppAssets.iconGoogle),


    );
  }



}
