import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_cubit.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_state.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_text_field.dart';
import 'package:movies/l10n/app_localizations.dart';
import '../../../../../core/utils/resource.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailCtrl = TextEditingController();
  AuthCubit cubit = getIt();
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context)!;
    return BlocListener<AuthCubit, AuthState>(
      bloc: cubit,
      listener: (context, state) {
        final forgotPassState = state.forgotPassServer;
        if (forgotPassState.isSuccess) {
          Navigator.pop(context);
        } else if (forgotPassState.status == AppStatus.error) {
          Fluttertoast.showToast(
            msg:
                forgotPassState.errorMessage ??
                " Something went Wrong Pleas try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(localization.forgetPassword)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset(AppAssets.forgotPassword),
                SizedBox(height: context.height * .026),
                CustomTextField(
                  controller: emailCtrl,
                  hintText: localization.emailHint,
                  prefixIcon: ImageIcon(
                    AssetImage(AppAssets.iconEmail),
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: context.height * .026),
          
                BlocBuilder<AuthCubit, AuthState>(
                  bloc: cubit,
                  builder: (context, state) {
                    final forgotPass = state.loginServer;
                    if (!forgotPass.isLoading) {
                      return CustomButton(
                        text: localization.verifyEmailButton,
                        onPressed: () {
                          cubit.forgotPass(emailCtrl.text.trim());
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.white),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
