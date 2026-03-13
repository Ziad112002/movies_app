import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_cubit.dart';
import 'package:movies/features/auth/ui/screens/cubit/auth_state.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';
import '../../../../../../core/utils/resource.dart';

class ProfileTab extends StatefulWidget {
   const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
final AuthCubit logoutCubit =getIt();

final AuthCubit currentUserCubit =getIt();
@override
  void initState() {
    super.initState();
    currentUserCubit.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthState>(
      bloc: logoutCubit,
      listener: (context,state){
        final result=state.logoutServer;
        if(result.isSuccess){
          Navigator.pushReplacement(context, AppRoutes.loginScreen);
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
      child: DefaultTabController(
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
                          BlocBuilder<AuthCubit,AuthState>(
                            bloc: currentUserCubit,
                            builder: (context,state) {
                              final currentUserState=state.currentUserServer;
                              if(currentUserState.isLoading){
                                return Center(child: CircularProgressIndicator(color: AppColors.white,),);
                              }else if(currentUserState.isSuccess&&currentUserState.data!=null){
                                var result =currentUserState.data;
                                return Column(
                                  crossAxisAlignment: .stretch,
                                  children: [
                                  buildProfileAvatarRow(context,result!.avatarUrl),
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 27.0),
                                    child: Text(
                                      result.name,
                                      textAlign: .start,
                                      style: context.textTheme.displayMedium?.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],);
                              }else{
                                return Text(
                                  "${currentUserState.errorMessage}",
                                  style: context.textTheme.headlineMedium,
                                );
                              }

                            }
                          ),
                          SizedBox(height: 20),
                          BlocBuilder<AuthCubit,AuthState>(
                            bloc: logoutCubit,
                            builder: (context,state) {
                              final result=state.logoutServer;
                              if(!result.isLoading){
                                return buildButtonsRow(context,onExitClick: ()async{await logoutCubit.logout();});
                              }else{
                                return CircularProgressIndicator(color: AppColors.white,);
                              }
                            }
                          ),
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
      ),
    );
  }

  Row buildProfileAvatarRow(BuildContext context,String avatarPath) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Container(
          height: context.height * .13,
          width: context.height * .13,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(avatarPath),
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

  Widget buildButtonsRow(BuildContext context,{required void Function()? onExitClick}) {
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
              onPress: onExitClick,
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
