import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/ImagePath.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/pages/OnBoarding/OnBoadring_widget.dart';

class OnboardingScreens extends StatefulWidget {
  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _controller = PageController();

  int currentPage = 0;

  void _goToNextPage() {
    if (currentPage < 2) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.loginPage, (context) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: [
          OnBoardingbase(
            image: OnbordingImage1_3,
            desc:
                'schedule visits with your preferred doctor in just a few clicks',
            title: 'Book your appointment easily',
            pageId: currentPage + 1,
            onButtonPressed: _goToNextPage,
          ),
          OnBoardingbase(
            image: OnbordingImage2,
            desc:
                "stay toned with your check-ups, follow-ups, and review your medication any time, anywhere.",
            title: 'Track your medication, visits, and prescriptions.',
            pageId: currentPage + 1,
            onButtonPressed: _goToNextPage,
          ),
          OnBoardingbase(
            image: OnbordingImage2,
            desc:
                "Manage appointments across different specialists and clinics.",
            title: 'Multi-clinic support in one platform',
            pageId: currentPage + 1,
            onButtonPressed: _goToNextPage,
          ),
        ],
      ),
    );
  }
}
