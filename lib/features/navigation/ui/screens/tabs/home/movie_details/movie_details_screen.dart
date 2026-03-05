import 'package:flutter/material.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Text("Movie Details",style: context.textTheme.headlineLarge,),
    );
  }
}
