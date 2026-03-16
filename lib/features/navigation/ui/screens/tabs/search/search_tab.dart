import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';
import 'package:movies/features/auth/ui/widgets/custom_text_field.dart';
import 'package:movies/features/navigation/domain/models/movie.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_cubit.dart';
import 'package:movies/features/navigation/ui/screens/cubit/movies_state.dart';
import 'package:movies/l10n/app_localizations.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController queryCtrl = TextEditingController();
  MoviesCubit searchCubit = getIt();
  Timer? _debounceTimer;
  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final trimmed = query.trim();
      if (trimmed.isEmpty) {
        return;
      }
      searchCubit.loadMovies(10, null, null, trimmed, "rating", null, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => searchCubit,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CustomTextField(
                hintText: localization.searchHint,
                controller: queryCtrl,
                onChanged: _onSearchChanged,
                prefixIcon: ImageIcon(
                  AssetImage(AppAssets.iconSearch),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) {
                  if (queryCtrl.text.trim().isEmpty) {
                    return Expanded(child: Image.asset(AppAssets.emptyList));
                  } else if (state.moviesApi.isLoading) {
                    return Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.white)));
                  } else if (state.moviesApi.isSuccess &&
                          state.moviesApi.data != null ||
                      state.moviesApi.data!.isEmpty) {
                    List<Movie> movies = state.moviesApi.data!;
                    if (movies.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            textAlign: .center,
                            "${localization.weDoNotFind} \"${queryCtrl.text.trim()}\"\n${localization.tryDifferentSpelling}",
                            style: context.textTheme.bodyLarge?.copyWith(color: AppColors.lightOrange),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: GridView.builder(
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
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "${state.moviesApi.errorMessage}",
                        style: context.textTheme.headlineMedium,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
