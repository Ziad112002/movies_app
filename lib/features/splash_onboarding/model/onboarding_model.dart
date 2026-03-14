import 'package:flutter/material.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final Color color;
  final Color transparentColor;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.transparentColor,
  });
}