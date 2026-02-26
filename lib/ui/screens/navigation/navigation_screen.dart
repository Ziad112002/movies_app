import 'package:flutter/material.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("data",style: context.textTheme.headlineLarge,),
    );
  }
}
