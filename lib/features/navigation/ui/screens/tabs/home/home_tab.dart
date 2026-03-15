import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/core/utils/resource.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_cubit.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_state.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  MoviesCubit availableNowCubit = getIt();
  MoviesCubit watchNowCubit = getIt();
   String? currentBgImageUrl;
  @override
  void initState() {
    super.initState();
    availableNowCubit.loadMovies(
      10,
      null,
      null,
      null,
      "data_added",
      "desc",
      null,
    );
    watchNowCubit.loadMovies(10, null, null, null, "seeds", "desc", 7);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => availableNowCubit),
        BlocProvider(create: (_) => watchNowCubit),
      ],
      child: Stack(
        children: [
          SizedBox(height: double.infinity, width: double.infinity),
         CachedNetworkImage(
           imageUrl:  currentBgImageUrl??"",
           placeholder: (context, url) => Center(
             child: CircularProgressIndicator(
               color: AppColors.white,
             ),
           ),
           errorWidget: (context, url, error) =>
               Icon(Icons.error, color: AppColors.red),
           fit: BoxFit.cover,
           width:
           double.infinity,
           height: double.infinity, ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF121312).withAlpha(204), // 80% opacity
                  const Color(0xFF121312).withAlpha(155), // 60% opacity
                  const Color(0xFF121312), // 100% opacity
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppAssets.availableNow),
                  BlocBuilder<MoviesCubit, MoviesState>(
                    bloc: availableNowCubit,
                    builder: (context, state) {
                      if (state.moviesApi.status == AppStatus.loading) {
                        return CircularProgressIndicator(
                          color: AppColors.white,
                        );
                      } else if (state.moviesApi.status == AppStatus.success &&
                          state.moviesApi.data != null) {
                        final movies = state.moviesApi.data;

                          currentBgImageUrl = state.moviesApi.data![6].largeCoverImage;


                        if (movies == null || movies.isEmpty) {
                          return const Center(
                            child: Text(
                              "No movies available",
                              style: TextStyle(fontSize: 30, color: AppColors.white),
                            ),
                          );
                        }
                        return CarouselSlider.builder(
                          //length
                          itemCount: state.moviesApi.data!.length,
                          itemBuilder: (context, index, pageViewIndex) {
                            return CustomMovieCard(
                              movie: state.moviesApi.data![index],
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
                            onPageChanged: (index,reason){
                                currentBgImageUrl = movies[index].largeCoverImage;
setState(() {
});
                            }
                          ),
                        );
                      } else {
                        return Text(
                          "${state.moviesApi.errorMessage}",
                          style: TextStyle(fontSize: 30, color: AppColors.white),
                        );
                      }
                    },
                  ),
                  Image.asset(AppAssets.watchNow),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text("Action", style: context.textTheme.bodyLarge),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text("See More", style: context.textTheme.labelMedium),
                              Icon(
                                Icons.arrow_forward_outlined,
                                size: 12,
                                color: AppColors.lightOrange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<MoviesCubit, MoviesState>(
                    bloc: watchNowCubit,
                    builder: (context, state) {
                      if (state.moviesApi.isLoading) {
                        return CircularProgressIndicator(
                          color: AppColors.white,
                        );
                      } else if (state.moviesApi.isSuccess &&
                          state.moviesApi.data != null) {
                        return buildMovieWatchList(context, state.moviesApi.data!);
                      } else {
                        return Text(
                          "${state.moviesApi.errorMessage}",
                          style: TextStyle(fontSize: 30, color: AppColors.white),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMovieWatchList(BuildContext context, List<Movie> watchNowList) {
    return SizedBox(
      height: context.height * .24,
      child: ListView.builder(
        itemCount: watchNowList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomMovieCard(
              movie: watchNowList[index],
              heightRatio: .24,
              widthRatio: .38,
            ),
          );
        },
      ),
    );
  }
}
