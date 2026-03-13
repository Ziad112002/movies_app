import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Image.asset(AppAssets.forgotPassword,),
            SizedBox(height: context.height*.026,),
            CustomTextField(hintText: "Email",prefixIcon: ImageIcon(AssetImage(AppAssets.iconEmail),color: AppColors.white,),),
            SizedBox(height: context.height*.026,),

            CustomButton(text: "Verify Email", onPress: (){

            })
          ],
        ),
      ),
    );
  }
}
