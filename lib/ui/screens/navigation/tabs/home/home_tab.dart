import 'package:flutter/material.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Home",style: context.textTheme.headlineLarge,),
    );
  }
}
