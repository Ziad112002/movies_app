import 'package:flutter/material.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Explore",style: context.textTheme.headlineLarge,),
    );
  }
}
