import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';

class CustomMovieCard extends StatelessWidget {
  const CustomMovieCard({super.key,required this.heightRatio,required this.widthRatio, this.movie});
  final double heightRatio;
  final double widthRatio;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
Navigator.push(context, AppRoutes.movieDetailsScreen);
      },
      child: Stack(
        children: [
          Container(
            height: context.height*heightRatio,
            width: context.width*widthRatio,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image:movie!=null? NetworkImage(movie!.mediumCoverImage):AssetImage(AppAssets.onBoarding_1917),fit: .cover,)
            ) ,
          ),
          Positioned(
            top:11 ,
            left: 9,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.softBlack.withAlpha(178),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(movie!=null?"${movie!.rating}":"7.7",style: context.textTheme.bodySmall?.copyWith(fontSize: 16),),
                  Icon(Icons.star_rate_sharp,color: AppColors.lightOrange,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
