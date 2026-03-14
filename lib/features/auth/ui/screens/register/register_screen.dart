import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/app_validators.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_cubit.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_state.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_carousel_slider.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  late String avtarPath;
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final AuthCubit _cubit=getIt();
  @override
  void dispose() {
    _phoneCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthState>(
      bloc: _cubit,
      listener:(context,state){
        final result=state.signUpServer;
        if(result.isSuccess){
          Navigator.push(context, AppRoutes.navigationScreen);
        }else if(result.status==AppStatus.error) {
          Fluttertoast.showToast(
              msg: result.errorMessage??" Something went Wrong Pleas try again later",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomCarouselSlider(
                    length: AppConstants.avatars.length,
                    itemBuilder: (context, itemIndex, pageViewIndex) {
                        avtarPath= AppConstants.avatars[itemIndex];
                      return Image.asset(
                        AppConstants.avatars[itemIndex],
                        fit: .contain,
                      );
                    },
                  ),
                  CustomTextField(
                    controller: _nameCtrl,
                    hintText: "Name",
                    validator:
                      AppValidators.generalValidator
                     ,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.iconIdentification),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: context.height * .024),
                  CustomTextField(
                    controller: _emailCtrl,
                    hintText: "Email",
                    validator:
                      AppValidators.emailValidator

                    ,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.iconEmail),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: context.height * .024),
                  CustomTextField(
                    controller: _passCtrl,
                    hintText: "Password",
                    validator:AppValidators.passValidator,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter your password';
                      }
                      // Comparison logic
                      if (value != _passCtrl.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
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
                    controller: _phoneCtrl,
                    hintText: "Phone Number",
                    validator:           AppValidators.generalValidator,
                    prefixIcon: ImageIcon(
                      AssetImage(AppAssets.iconCall),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: context.height * .024),
                BlocBuilder<AuthCubit,AuthState>(
                  bloc: _cubit,
                  builder: (context,state) {
                    final result=state.signUpServer;
                    if(!result.isLoading){
                      return CustomButton(
                          text: "Create Account",
                          onPressed: ()  {
                            if(!_formKey.currentState!.validate())return;
                          _cubit.signUp(_emailCtrl.text, _passCtrl.text, _nameCtrl.text, _phoneCtrl.text, avtarPath);
                          }
                      );
                    }else{
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.white,),
                      );
                    }

                  }
                ),
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
                          Navigator.pop(context);
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

                 buildLocalizationButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildLocalizationButton() {
    return    Switch(
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
    );
  }
}

