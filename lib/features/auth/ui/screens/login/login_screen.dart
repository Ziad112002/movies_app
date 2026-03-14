import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/app_validators.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_cubit.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_state.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import '../../../../../core/di/di.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  AuthCubit loginCubit = getIt();
  AuthCubit loginWithGoogleCubit = getIt();
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthState>(
      bloc: loginWithGoogleCubit,
      listener: (context, state) {
        final loginWithGoogleState  = state.loginWithGoogleServer;
        if (loginWithGoogleState.isSuccess) {
          Navigator.push(context, AppRoutes.navigationScreen);
        } else if (loginWithGoogleState.status == AppStatus.error) {
          Fluttertoast.showToast(
            msg:
            loginWithGoogleState.errorMessage ??
                "Something went Wrong Pleas try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: BlocListener<AuthCubit, AuthState>(
        bloc: loginCubit,
        listener: (context, state) {
          final loginState = state.loginServer;
          if (loginState.isSuccess) {
            Navigator.push(context, AppRoutes.navigationScreen);
          } else if (loginState.status == AppStatus.error) {
            Fluttertoast.showToast(
              msg:
                  loginState.errorMessage ??
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
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        AppAssets.movieLogo,
                        height: context.height * .13,
                      ),
                      SizedBox(height: context.height * .07),
                      CustomTextField(
                        controller: _emailCtrl,
                        validator: AppValidators.emailValidator,
                        hintText: "Email",
                        prefixIcon: Image.asset(AppAssets.iconEmail),
                      ),
                      SizedBox(height: context.height * .024),
                      CustomTextField(
                        controller: _passCtrl,
                        hintText: "Password",
                        validator: AppValidators.passValidator,
                        isObscure: isObscure,
                        prefixIcon: Image.asset(AppAssets.iconLock),
                        suffixIcon: Image.asset(AppAssets.iconEyeOff),
                      ),
                      SizedBox(height: context.height * .018),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, AppRoutes.forgetPasswordScreen);
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
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: loginCubit,
                        builder: (context, state) {
                          final result = state.loginServer;
                          if (!result.isLoading) {
                            return CustomButton(
                              text: "Login",
                              onPressed: () {
                                if(!_formKey.currentState!.validate()) return;
                                loginCubit.login(
                                  _emailCtrl.text,
                                  _passCtrl.text,
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            );
                          }
                        },
                      ),
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
                                fontWeight: FontWeight.w900,
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
                      BlocBuilder<AuthCubit,AuthState>(
                        bloc: loginWithGoogleCubit,
                        builder: (context,state) {
                          final loginWithGoogleState=state.loginWithGoogleServer;
                          if(!loginWithGoogleState.isLoading){
                            return CustomButton(
                              onPressed: ()  {
                                 loginWithGoogleCubit.loginWithGoogle();
                              },
                              text: 'Login With Google',
                              icon: Image.asset(AppAssets.iconGoogle),
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            );
                          }

                        }
                      ),
                      SizedBox(height: context.height * .036),
                      buildLocalizationButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLocalizationButton() {
    return Switch(
      trackOutlineColor: WidgetStatePropertyAll(AppColors.lightOrange),
      inactiveTrackColor: Colors.transparent,
      inactiveThumbColor: AppColors.lightOrange,
      activeTrackColor: Colors.transparent,
      activeThumbColor: AppColors.lightOrange,
      activeThumbImage: AssetImage(AppAssets.iconEgypt),
      inactiveThumbImage: AssetImage(AppAssets.iconUS),
      value: false,
      onChanged: (value) {},
    );
  }
}
