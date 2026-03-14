import 'package:flutter/material.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/core/utils/app_colors.dart';
import 'package:movies/core/utils/app_routes.dart';
import 'package:movies/core/utils/extensions/context_extension.dart';
import 'package:movies/features/auth/ui/widgets/custom_button.dart';
import 'package:movies/features/splash_onboarding/model/onboarding_model.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  List<OnboardingModel> items = AppConstants.onboardingItems;

  void nextPage() {
    if (currentPage < items.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: items.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final item = items[index];

          return Stack(
            children: [
              SizedBox(height: double.infinity, width: double.infinity),
              Image.asset(item.image, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [item.transparentColor, item.color],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: buildBottomSheet(item, context, index),
              ),
            ],
          );
        },
      ),
    );
  }

  Container buildBottomSheet(OnboardingModel item, BuildContext context, int index) {
    return Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      item.title,
                      style: context.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    if(item.description.isNotEmpty)Text(
                      item.description,
                      style: context.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    CustomButton(
                      onPressed: () {
                        if (index == items.length - 1) {
                         Navigator.push(context, AppRoutes.loginScreen);
                        } else {
                          nextPage();
                        }
                      },
                      text: index == items.length - 1 ? "Finish" : "Next",
                    ),

                    const SizedBox(height: 10),

                    if (index != 0)
                      CustomButton(
                        isBorder: true,
                        onPressed: previousPage,
                        background: AppColors.black,
                        text: "Back",
                        style: context.textTheme.labelLarge?.copyWith(
                          color: AppColors.lightOrange,
                        ),
                      ),
                  ],
                ),
              );
  }
}
