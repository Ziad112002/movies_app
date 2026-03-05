import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return
             [
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.softBlack,
                    padding: EdgeInsets.only(
                      top: context.height * .05,
                  
                    ),
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        buildProfileAvatarRow(context),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 27.0),
                          child: Text(
                            "Ziad Hammad",
                            textAlign: .start,
                            style: context.textTheme.displayMedium?.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        buildButtonsRow(context),
                        SizedBox(height: 20),
                  
                        TabBar(
                          dividerHeight: 0,
                          indicatorColor: AppColors.lightOrange,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: AppColors.white,
                          labelStyle: context.textTheme.bodyLarge,
                          unselectedLabelColor: AppColors.white,
                          tabs: [
                            Tab(
                              text: "Watch List",
                              icon: ImageIcon(AssetImage(AppAssets.iconList),
                                color: AppColors.lightOrange,),
                            ),
                            Tab(
                              text: "History",
                              icon: ImageIcon(AssetImage(AppAssets.iconFolder),
                                color: AppColors.lightOrange,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ];
          }, body:TabBarView(children: [
        buildGridView(),
        buildGridView()

      ]) ,
      ),
    );
  }

  Row buildProfileAvatarRow(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Container(
          height: context.height * .13,
          width: context.height * .13,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.gamer2),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
        Column(
          children: [
            Text("12", style: context.textTheme.headlineLarge),
            Text("Wish List", style: context.textTheme.headlineSmall),
          ],
        ),
        Column(
          children: [
            Text("10", style: context.textTheme.headlineLarge),
            Text("History", style: context.textTheme.headlineSmall),
          ],
        ),
      ],
    );
  }

  Widget buildButtonsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomButton(text: "Edit Profile", onPress: () {
              Navigator.push(context, AppRoutes.profileDetailsScreen);

            }),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: CustomButton(
              text: "Exit",
              icon2: Icon(Icons.exit_to_app_outlined,color: AppColors.white,),
              onPress: () {},
              background: AppColors.red,
              style: context.textTheme.labelLarge?.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  GridView buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.only(right:16 ,top: 16,left: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return CustomMovieCard(heightRatio: .3, widthRatio: .44);
      },
    );
  }

}
