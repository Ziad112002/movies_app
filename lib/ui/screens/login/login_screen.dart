
import 'package:flutter/material.dart';
import 'package:movies/ui/utils/app_assets.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';
import 'package:movies/ui/widgets/custom_button.dart';
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
                    color: context.secondaryColor,
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

                        },
                        child: Text(
                          "Create One",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.secondaryColor,
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
                    trackOutlineColor: WidgetStatePropertyAll(context.secondaryColor),
                    inactiveTrackColor: Colors.transparent,
                    inactiveThumbColor: context.secondaryColor,
                    activeTrackColor: Colors.transparent,
                    activeThumbColor: context.secondaryColor,
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
      onPress: () {},
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
