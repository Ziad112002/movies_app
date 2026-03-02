import 'package:flutter/material.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Search",style: context.textTheme.headlineLarge,),
    );
  }
}
