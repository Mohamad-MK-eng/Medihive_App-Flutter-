import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';

class ExclusiveOffersSlider extends StatefulWidget {
  const ExclusiveOffersSlider({Key? key}) : super(key: key);

  @override
  State<ExclusiveOffersSlider> createState() => _ExclusiveOffersSliderState();
}

class _ExclusiveOffersSliderState extends State<ExclusiveOffersSlider> {
  int _currentPage = 0;

  // بيانات وهمية للعروض
  final List<Map<String, String>> _offers = [
    {
      'title': 'Dental Checkup Offer',
      'description': 'Comprehensive checkup and scaling included.',
      'clinic': 'Smile Dental Clinic',
      'doctor': 'Adam Smith',
      'discount': '50%',
      'image': 'assets/images/Doctor.png',
    },
    {
      'title': 'Skin Glow Package',
      'description': 'Deep cleansing & rejuvenation therapy.',
      'clinic': 'DermaCare Center',
      'doctor': 'Lana Kareem',
      'discount': '35%',
      'image': 'assets/images/Doctor.png',
    },
    {
      'title': 'Eye Checkup',
      'description': 'Advanced vision testing and consultation.',
      'clinic': 'Vision Eye Clinic',
      'doctor': 'Omar Aziz ',
      'discount': '40%',
      'image': 'assets/images/Doctor.png',
    },
  ];

  // إعداد الانيميشن التلقائي للتبديل بين العروض كل 5 ثواني
  final PageController _pageController = PageController();
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    startAutoSlide();
  }

  void startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(Duration(seconds: 5), (_) {
      if (_pageController.hasClients) {
        int currentPage = _pageController.page?.floor() ?? 0;
        int nextPage = currentPage + 1;
        if (nextPage >= _offers.length) nextPage = 0;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  // تصميم كل عرض داخل السلايدر
  Widget _buildOfferCard(Map<String, String> offer) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [lightSky, Colors.blue.shade300],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        /*  */
      ),

      // 👇 هذا هو اللي بيمنع الـ Row من التمدد الكامل
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ✅ النصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  offer['title']!,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: montserratFont,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  offer['description']!,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                /*  Text(
                  'Clinic: ${offer['clinic']}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ), */
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: hardmintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Check now"),
                    ),
                    const SizedBox(
                      width: 30,
                      height: 5,
                    ),
                    Text(
                      offer['discount']!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // ✅ الصورة
          Column(
            children: [
              Container(
                width: Appdimensions.getWidth(90),
                height: Appdimensions.getHight(100),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: hardmintGreen,
                      width: 2,
                    ),
                  ),
                ),
                child: offer['image'] != null
                    ? Image.network(
                        fit: BoxFit.cover,
                        offer['image']!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/Doctor.png',
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: 120,
                child: Text(
                  'Dr: ${offer['doctor']}',
                  textAlign: TextAlign.center,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // المؤشرات (الدوائر) أسفل العروض
  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blueAccent : Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 150,
          //   fit: FlexFit.tight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _offers.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) => GestureDetector(
              child: _buildOfferCard(_offers[index]),
              onTapDown: (_) => stopAutoSlide(), // يوقف عند اللمس
              onTapUp: (_) => startAutoSlide(), // يرجّع بعد رفع اليد
              onPanStart: (_) => stopAutoSlide(), // يوقف عند السحب
              onPanEnd: (_) => startAutoSlide(),
              onLongPress: () => stopAutoSlide(),
              onLongPressEnd: (_) => startAutoSlide(),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              List.generate(_offers.length, (index) => _buildIndicator(index)),
        ),
      ],
    );
  }
}
