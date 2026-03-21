import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/app_dialogs.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/domain/entity/user_entity.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_cubit.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_text_field.dart';
import 'package:movies/l10n/app_localizations.dart';

import '../../../../../../core/utils/resource.dart';
import '../../../../../auth/ui/screens/cubit/auth_state.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key, required this.userInfo});
  final UserEntity userInfo;
  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
final  TextEditingController _nameCtrl = TextEditingController();
 final TextEditingController _phoneCtrl = TextEditingController();
  int? _selectedIndex;
  late String path = widget.userInfo.avatarUrl;
  AuthCubit resetPassCubit = getIt();
  final AuthCubit _deleteAccountCubit = getIt();
  final AuthCubit _updateAccountCubit = getIt();
  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _updateAccountCubit,
      listener: (context, state) {
        final updateAccount = state.updateAccountServer;
        if (updateAccount.isSuccess) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.profileUpdated,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (updateAccount.status == AppStatus.error) {
          Fluttertoast.showToast(
            msg:
                updateAccount.errorMessage ??
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
      child: BlocListener<AuthCubit, AuthState>(
        bloc: _deleteAccountCubit,
        listener: (context, state) {
          final deleteAccountState = state.deleteAccountServer;

          if (deleteAccountState.isSuccess) {
            Navigator.pushReplacement(context, AppRoutes.loginScreen);
          } else if (deleteAccountState.status == AppStatus.error) {
            Fluttertoast.showToast(
              msg:
                  deleteAccountState.errorMessage ??
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
        child: BlocListener<AuthCubit, AuthState>(
          bloc: resetPassCubit,
          listener: (context, state) {
            final forgotPassState = state.forgotPassServer;
            if (forgotPassState.isSuccess) {
              Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.passwordResetEmailSent,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
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
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.pickAvatar),),
            body: SafeArea(
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => buildAvatarList(),
                          );
                        },
                        child: Container(
                          height: context.height * .16,
                          width: context.height * .16,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: path.startsWith('assets/')
                                  ? AssetImage(path)
                                  : NetworkImage(path),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(height: context.height * .04),
                      CustomTextField(
                        hintText: widget.userInfo.name,
                        controller: _nameCtrl,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.iconUser),
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: context.height * .021),
                      CustomTextField(
                        hintText: widget.userInfo.phoneNumber,
                        controller:_phoneCtrl,
                        prefixIcon: Icon(Icons.call, color: AppColors.white),
                      ),
                      SizedBox(height: context.height * .032),
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: resetPassCubit,
                        builder: (context, state) {
                          final forgotPass = state.loginServer;
                          if (!forgotPass.isLoading) {
                            return InkWell(
                              onTap: () {
                                resetPassCubit.forgotPass(widget.userInfo.email);
                              },
                              overlayColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.resetPassword,
                                textAlign: .start,
                                style: context.textTheme.bodyLarge,
                              ),
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
                      SizedBox(height: context.height * .26),
              
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: _deleteAccountCubit,
                        builder: (context, state) {
                          final deleteAccount = state.deleteAccountServer;
                          if (!deleteAccount.isLoading) {
                            return buildDeleteAccountButton(
                              onPress: () {
                                showMessage(
                                  context,
                                  AppLocalizations.of(context)!.areYouSure,
                                  title: AppLocalizations.of(context)!.deleteAccount,
                                  posText: AppLocalizations.of(context)!.ok,
                                  onPosClick: () {
                                    _deleteAccountCubit.deleteAccount();
                                    Navigator.pushReplacement(context, AppRoutes.loginScreen);
                                  },
                                  negText: AppLocalizations.of(context)!.no,
                                  onNegClick: () {
                                    Navigator.pop(context);
                                  },
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
                      SizedBox(height: context.height * .021),
              
                      BlocBuilder<AuthCubit, AuthState>(
                        bloc: _updateAccountCubit,
                        builder: (context, state) {
                          final updateAccountState = state.updateAccountServer;
                          if (!updateAccountState.isLoading) {
                            return buildUpdateAccountButton(onPress: () {
                              _updateAccountCubit.updateAccount(_nameCtrl.text.isEmpty?widget.userInfo.name:_nameCtrl.text, _phoneCtrl.text.isEmpty?widget.userInfo.phoneNumber:_phoneCtrl.text, path);
                            });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            );
                          }
                        },
                      ),
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
  CustomButton buildDeleteAccountButton({required void Function()? onPress}) {
    return CustomButton(
      background: AppColors.red,
      style: context.textTheme.bodyLarge,
      text: AppLocalizations.of(context)!.deleteAccount,
      onPressed: onPress,
    );
  }

  CustomButton buildUpdateAccountButton({required void Function()? onPress}) {
    return CustomButton(text: AppLocalizations.of(context)!.updateAccount, onPressed: onPress);
  }

  Widget buildAvatarList() {
    return Container(
      width: context.width * .94,
      height: context.height * .42,
      decoration: BoxDecoration(
        color: AppColors.softBlack,
        borderRadius: BorderRadius.circular(24),
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(19),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 16,
        ),

        itemCount: AppConstants.avatars.length,
        itemBuilder: (context, index) {
          return buildAvatarContainer(AppConstants.avatars[index], index);
        },
      ),
    );
  }

  Widget buildAvatarContainer(String avatarPath, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        _selectedIndex = index;
        path = AppConstants.avatars[index];
        setState(() {});
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lightOrange.withAlpha(127)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: BoxBorder.all(color: AppColors.lightOrange),
        ),
        child: Image.asset(avatarPath, width: 105, height: 105),
      ),
    );
  }
}
