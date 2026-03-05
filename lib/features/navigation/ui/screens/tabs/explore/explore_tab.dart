import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}
int _selectedIndex=0;

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                onTap: (index){
                  _selectedIndex=index;
                  setState(() {

                  });
                },
                tabAlignment: .start,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                dividerHeight: 0,
                tabs: [
                  buildTabContainer(
                    Text(
                      "Action",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: _selectedIndex==0?AppColors.black:AppColors.lightOrange,
                        fontWeight: .bold,
                      ),
                    ),
                      _selectedIndex==0

                  ),
                  buildTabContainer(
                    Text(
                      "Adventure",
                      style: context.textTheme.labelMedium?.copyWith(
                        color:  _selectedIndex==1?AppColors.black:AppColors.lightOrange,
                        fontWeight: .bold,
                      ),
                    ),
                    _selectedIndex==1
                  ),
                  buildTabContainer(
                    Text(
                      "Adventure",
                      style: context.textTheme.labelMedium?.copyWith(
                        color:  _selectedIndex==2?AppColors.black:AppColors.lightOrange,
                        fontWeight: .bold,
                      ),
                    ),
                      _selectedIndex==2

                  ),
                ],
              ),
              SizedBox(height: context.height * .02),
              Expanded(
                child: TabBarView(
                  children: [
                    buildGridView(),
                    buildGridView(),
                    buildGridView(),
                    buildGridView(),
                    buildGridView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return CustomMovieCard(heightRatio: .3, widthRatio: .44);
      },
    );
  }

  Widget buildTabContainer(Text text,bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected?AppColors.lightOrange:AppColors.black,
        border: isSelected?null:BoxBorder.all(
          color: AppColors.lightOrange,width: 2
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: text,
    );
  }
}
