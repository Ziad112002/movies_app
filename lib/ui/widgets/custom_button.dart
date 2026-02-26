
import 'package:flutter/material.dart';
import 'package:movies/ui/utils/extensions/context_extension.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? background;
  final Widget? icon;
  final VoidCallback? onPress;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPress,
    this.icon,
    this.background,
     this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: background??context.secondaryColor,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          )
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 9)],
          Text(text, style: style??context.textTheme.labelLarge),
        ],
      ),
    );
  }
}
