import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/features/auth/ui/widgets/custom_movie_card.dart';
import 'package:movies/features/auth/ui/widgets/custom_text_field.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomTextField(
              hintText: "Search",
              prefixIcon: ImageIcon(
                AssetImage(AppAssets.iconSearch),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
                child: GridView.builder(
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
            ))
          ],
        ),
      ),
    );
  }
}
