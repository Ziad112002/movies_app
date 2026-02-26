import 'package:flutter/material.dart';
import 'package:movies/ui/utils/app_assets.dart';
import 'package:movies/ui/utils/app_constants.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';
import 'package:movies/ui/widgets/custom_button.dart';
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
      appBar: AppBar(
        title: Text("Register"),
        leading: Icon(Icons.arrow_back),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height:  context.height*.17,
                  child: ListView.builder(
                    scrollDirection: .horizontal,
                    itemCount: AppConstants.avatars.length,
                      itemBuilder: (context,index){
                      return Image.asset(AppConstants.avatars[index],height: context.height*.17,);
                      }),
                ),
                CustomTextField(
                  controller: emailCtrl,
                  hintText: "Name",
                  prefixIcon:  ImageIcon(AssetImage(AppAssets.iconIdentification),color: Colors.white,),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: "Email",
                  prefixIcon:  ImageIcon(AssetImage(AppAssets.iconEmail),color: Colors.white,),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: "Password",
                  isObscure: isObscure,
                  prefixIcon:  ImageIcon(AssetImage(AppAssets.iconLock),color: Colors.white,),
                  suffixIcon:  ImageIcon(AssetImage(AppAssets.iconEyeOff),color: Colors.white,),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: "Confirm Password",
                  isObscure: isObscure,
                  prefixIcon:  ImageIcon(AssetImage(AppAssets.iconLock),color: Colors.white,),
                  suffixIcon:  ImageIcon(AssetImage(AppAssets.iconEyeOff),color: Colors.white,),
                ),
                SizedBox(height: context.height * .024),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: "Phone Number",
                  prefixIcon: ImageIcon(AssetImage(AppAssets.iconCall),color: Colors.white,),

                ),
                SizedBox(height: context.height * .024),
                buildCreateAccountButton(),
                SizedBox(height: context.height * .02),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Don’t Have Account ? ",
                      style: context.textTheme.bodySmall,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Create One",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.secondaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * .025),

                Switch(
                  trackOutlineColor: WidgetStatePropertyAll(
                    context.secondaryColor,
                  ),
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
    );
  }

  Widget buildCreateAccountButton() {
    return CustomButton(text: "Create Account", onPress: () {});
  }
}
