import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_cubit.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_state.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}



class _ExploreTabState extends State<ExploreTab> {
  int _selectedIndex = 0;
    String _selectedGenre=AppConstants.allMovieGenres[0];
  MoviesCubit cubit=getIt();
  final List<String>_allGenres=AppConstants.allMovieGenres;
  void _loadMoviesForGenre(String genre){
    cubit.loadMovies(14, 1, genre, null, "year", "desc", 7);
  }
  @override
  void initState() {
    super.initState();
    _loadMoviesForGenre(_selectedGenre);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DefaultTabController(
          length: AppConstants.allMovieGenres.length,
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                    _selectedGenre=AppConstants.allMovieGenres[index];
                  });
                  _loadMoviesForGenre(_selectedGenre);
                },
                tabAlignment: .start,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                dividerHeight: 0,
                tabs: _allGenres.asMap().entries.map((entry) {
                  // function as map show me current index and value
                  int index = entry.key;
                   final genre = entry.value;
                  bool isActive = _selectedIndex == index;
                  return buildTabContainer(
                    Text(
                      genre,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: .bold,
                        color: isActive
                            ? AppColors.black
                            : AppColors.lightOrange,
                      ),
                    ),
                    isActive,
                  );
                }).toList(),
              ),
              SizedBox(height: context.height * .02),
              BlocProvider(
                create: (_)=> cubit,
                child: BlocBuilder<MoviesCubit,MoviesState>(
                  builder: (context,state) {
                    final moviesStates=state.moviesApi;

                    if(moviesStates.isLoading){
                      return Expanded(child: Center(
                        child: CircularProgressIndicator(color: AppColors.white,),
                      ));
                    }else if(moviesStates.isSuccess&&moviesStates.data!=null){
                      var movies=moviesStates.data!;
                      return Expanded(
                        child: TabBarView(
                            children: _allGenres.map((genre){
                              return buildGridView(movies);
                            }).toList()
                        ),
                      );
                    }else{
                      return Text(
                        "${moviesStates.errorMessage}",
                        style: context.textTheme.headlineMedium,);
                    }

                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildGridView(List<Movie>movies) {
    return GridView.builder(
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
            heightRatio: .3, widthRatio: .44);
      },
    );
  }

  Widget buildTabContainer(Text text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.lightOrange : AppColors.black,
        border: BoxBorder.all(color: AppColors.lightOrange, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: text,
    );
  }
}
