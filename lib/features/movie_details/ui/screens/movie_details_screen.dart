import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/movie_details/domain/models/movie_details.dart';
import 'package:movies/features/movie_details/ui/screens/cubit/movie_details_cubit.dart';
import 'package:movies/features/movie_details/ui/screens/cubit/movie_details_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../auth/ui/widgets/custom_movie_card.dart';
import '../../../navigation/domain/models/movie.dart';
import '../../domain/models/cast.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    cubit.loadMovieDetails(widget.movieId);
    cubit.loadSimilarMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            final movieDetailsState = state.movieDetailsApi;
            if (movieDetailsState.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.white),
              );
            } else if (movieDetailsState.isSuccess &&
                movieDetailsState.data != null) {
              MovieDetails data = movieDetailsState.data!;
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black, // Top is visible
                            Colors.transparent, // Bottom fades out
                          ],
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: CachedNetworkImage(
                        imageUrl: data.coverImage,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: AppColors.red),
                        height: context.height * .7,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .stretch,
                          children: [
                            buildHeader(),
                            SizedBox(height: context.height * .2),
                            buildPlayButton(),
                            SizedBox(height: context.height * .2),
                            Text(
                              data.title,
                              textAlign: .center,
                              style: context.textTheme.headlineSmall,
                            ),
                            SizedBox(height: context.height * .017),
                            Text(
                              data.year.toString(),
                              textAlign: .center,
                              style: context.textTheme.displayMedium?.copyWith(
                                color: Color(0xffADADAD),
                              ),
                            ),
                            SizedBox(height: context.height * .009),
                            buildWatchButton(data.watchUrl),
                            SizedBox(height: context.height * .017),
                            buildReviewsRow(
                              data.likes,
                              data.watchCount,
                              data.rating,
                            ),
                            SizedBox(height: context.height * .017),
                            Text(
                              "Screen Shots",
                              textAlign: .start,
                              style: context.textTheme.headlineSmall,
                            ),
                            SizedBox(height: context.height * .017),
                            buildScreenshotImage(data.screenshot1),
                            SizedBox(height: context.height * .014),
                            buildScreenshotImage(data.screenshot2),
                            SizedBox(height: context.height * .014),
                            buildScreenshotImage(data.screenshot3),
                            SizedBox(height: context.height * .017),
                            Text(
                              "Similar",
                              textAlign: .start,
                              style: context.textTheme.headlineSmall,
                            ),
                            SizedBox(height: context.height * .017),
                            BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
                              builder: (context, state) {
                                final similarState = state.similarMoviesApi;
                                if (similarState.isLoading) {
                                  return CircularProgressIndicator(
                                    color: AppColors.white,
                                  );
                                } else if (similarState.isSuccess &&
                                    similarState.data != null) {
                                  List<Movie> movies = similarState.data!;
                                  return buildGridView(movies);
                                } else {
                                  return Text(
                                    "${similarState.errorMessage}",
                                    style: context.textTheme.headlineMedium,
                                  );
                                }
                              },
                            ),
                            SizedBox(height: context.height * .017),
                            Text(
                              "Summary",
                              textAlign: .start,
                              style: context.textTheme.headlineSmall,
                            ),
                            SizedBox(height: context.height * .01),
                            Text(
                              data.desc,
                              textAlign: .start,
                              style: context.textTheme.displaySmall,
                            ),
                            SizedBox(height: context.height * .017),
                            Text(
                              "Cast",
                              textAlign: .start,
                              style: context.textTheme.headlineSmall,
                            ),
                            SizedBox(height: context.height * .01),
                            buildCastList(data.cast),
                            SizedBox(height: context.height * .017),
                            Text(
                              "Genres",
                              textAlign: .start,
                              style: context.textTheme.headlineSmall,
                            ),
                            SizedBox(height: context.height * .01),
                            buildGenresGridView(data.genres),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text(
                "${movieDetailsState.errorMessage}",
                style: context.textTheme.headlineMedium,
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 30),
        ),
        Spacer(),
        Icon(Icons.bookmark, color: AppColors.white, size: 30),
      ],
    );
  }

  Widget buildPlayButton() => CircleAvatar(
    backgroundColor: AppColors.lightOrange,
    radius: 45,
    child: CircleAvatar(
      backgroundColor: AppColors.white,
      radius: 40,
      child: CircleAvatar(
        backgroundColor: AppColors.lightOrange,
        radius: 30,
        child: Icon(Icons.play_arrow, color: AppColors.white, size: 40),
      ),
    ),
  );

  Widget buildWatchButton(String uri) {
    return CustomButton(
      text: "Watch",
      background: AppColors.red,
      onPress: (){
        _launchUrl(uri);
      },
    );
  }
  Future<void>_launchUrl(String uri)async{

    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }

  Widget buildReviewsRow(int likes, int watchCount, double rating) {
    return Row(
      children: [
        Expanded(
          child: buildReviewContainer(
            Icon(Icons.favorite, color: AppColors.lightOrange),
            "$likes",
          ),
        ),
        SizedBox(width: context.width * .02),
        Expanded(
          child: buildReviewContainer(
            Icon(Icons.access_time_filled, color: AppColors.lightOrange),
            "$watchCount",
          ),
        ),
        SizedBox(width: context.width * .02),
        Expanded(
          child: buildReviewContainer(
            Icon(Icons.star, color: AppColors.lightOrange),
            "$rating",
          ),
        ),
      ],
    );
  }

  Widget buildReviewContainer(Widget icon, String s) {
    return Container(
      padding: EdgeInsets.only(top: 11, bottom: 11, left: 25),
      width: context.width * .283,
      decoration: BoxDecoration(
        color: AppColors.softBlack,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          icon,
          SizedBox(width: context.width * .02),
          Expanded(child: Text(s, style: context.textTheme.headlineSmall)),
        ],
      ),
    );
  }

  Widget buildScreenshotImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.lightOrange),
          ),
        ),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: AppColors.red),
        fit: .contain,
      ),
    );
  }

  Widget buildGridView(List<Movie> movies) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return CustomMovieCard(
          movie: movies[index],
          heightRatio: .3,
          widthRatio: .44,
        );
      },
    );
  }

  Widget buildCastList(List<Cast> castCrew) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: castCrew.length,
      itemBuilder: (context, index) => buildCastInfoCard(castCrew[index]),
    );
  }

  Widget buildCastInfoCard(Cast cast) {
    return Container(
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.softBlack,
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: CachedNetworkImage(
              imageUrl: cast.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColors.red),
              height: context.height * .075,
              width: context.height * .075,
              fit: .contain,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Name : ${cast.actorName}",
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  "Character : ${cast.characterName}",
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGenresGridView(List<String> genres) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 16,
        childAspectRatio: 3,
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 9),
          width: context.width * .283,
          alignment: .center,
          decoration: BoxDecoration(
            color: AppColors.softBlack,
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
          child: Text(genres[index], style: context.textTheme.displaySmall),
        );
      },
    );
  }
}
