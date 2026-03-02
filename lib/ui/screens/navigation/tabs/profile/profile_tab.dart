import 'package:flutter/material.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile",style: context.textTheme.headlineLarge,),
    );
  }
}
