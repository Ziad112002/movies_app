import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_text_field.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  int? _selectedIndex;
  String? path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Avatar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.lightOrange),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => buildAvatarList(context),
                );
              },
              child: Container(
                height: context.height * .16,
                width: context.height * .16,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      path == null
                          ? AppAssets.gamer2
                          : AppConstants.avatars[_selectedIndex!],
                    ),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: context.height * .04),
            CustomTextField(
              hintText: "Name",
              prefixIcon: ImageIcon(
                AssetImage(AppAssets.iconUser),
                color: AppColors.white,
              ),
            ),
            SizedBox(height: context.height * .021),
            CustomTextField(
              hintText: "Phone Number",
              prefixIcon: Icon(Icons.call, color: AppColors.white),
            ),
            SizedBox(height: context.height * .032),

            InkWell(
              onTap: () {},
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              child: Text(
                "Reset Password",
                textAlign: .start,
                style: context.textTheme.bodyLarge,
              ),
            ),
            Spacer(),
            buildDeleteAccountButton(context),
            SizedBox(height: context.height * .021),

            buildUpdateAccountButton(),
          ],
        ),
      ),
    );
  }

  CustomButton buildDeleteAccountButton(BuildContext context) {
    return CustomButton(
      background: AppColors.red,
      style: context.textTheme.bodyLarge,
      text: "Delete Account",
      onPress: () {},
    );
  }

  CustomButton buildUpdateAccountButton() {
    return CustomButton(text: "Update Account", onPress: () {});
  }

  Widget buildAvatarList(BuildContext context) {
    return Container(
      width: context.width *.94,
      height: context.height *.42,
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

  Widget buildAvatarContainer(String avatarPath, int index,) {
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
