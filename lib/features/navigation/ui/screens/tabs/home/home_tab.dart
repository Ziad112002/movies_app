import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/constants/app_constants.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Image.asset(AppAssets.availableNow),
        CarouselSlider.builder(
          itemCount: AppConstants.avatars.length,
          itemBuilder: (context,index,pageViewIndex){
            return CustomMovieCard(
              heightRatio: .38,
              widthRatio: .59,
            );
          },
          options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlay: false,
            disableCenter: true,
            enlargeCenterPage: true,
            height: context.height * .38,
            enlargeFactor: .6,
            aspectRatio: 2,
            viewportFraction: 0.5,
            initialPage: 6,
          ),
        ),
            Image.asset(AppAssets.watchNow),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(

                children: [
                  Text("Action",style: context.textTheme.bodyLarge,),
                  Spacer(),
                  InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Text("See More",style: context.textTheme.labelMedium,),
                        Icon(Icons.arrow_forward_outlined,size:12,color: AppColors.lightOrange,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            buildMovieWatchList(context)


          ],
        ),
      ),
    );
  }

  Widget buildMovieWatchList(BuildContext context) {
    return SizedBox(
      height: context.height*.24,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomMovieCard(heightRatio: .24,widthRatio: .38,),
        );
      }),
    );
  }
}
