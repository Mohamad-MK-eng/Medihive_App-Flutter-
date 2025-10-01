import 'package:flutter/material.dart';
import 'package:medihive_1_/helper/Routes.dart';

class OnBoardingbase extends StatelessWidget {
  OnBoardingbase(
      {required this.image,
      required this.desc,
      required this.title,
      required this.pageId,
      required this.onButtonPressed});

  String image;
  String title;
  String desc;
  int pageId;
  Function() onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF1E90FF),
          const Color(0xFF76C6E0),
          const Color(0xFFA8E6CF),
          const Color(0xFFF5F5F5),
        ],
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 110,
            ),
            Container(
              width: 350,
              height: 235,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Jomolhari',
                  fontWeight: FontWeight.w400,
                  // height: 1.40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: pageId == 1 ? 57 + 5 : 57,
                    height: pageId == 1 ? 15 + 10 : 15,
                    decoration: ShapeDecoration(
                      color:
                          pageId == 1 ? Color(0xFF03B1A2) : Color(0xFF1E90FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Container(
                    width: pageId == 2 ? 57 + 5 : 57,
                    height: pageId == 2 ? 15 + 10 : 15,
                    decoration: ShapeDecoration(
                      color:
                          pageId == 2 ? Color(0xFF03B1A2) : Color(0xFF1E90FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Container(
                    width: pageId == 3 ? 57 + 5 : 57,
                    height: pageId == 3 ? 15 + 10 : 15,
                    decoration: ShapeDecoration(
                      color:
                          pageId == 3 ? Color(0xFF03B1A2) : Color(0xFF1E90FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {
                onButtonPressed();
              },
              child: Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffA8E6CF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  pageId == 3 ? 'Get started' : 'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Jomolhari',
                    fontWeight: FontWeight.w400,
                    // height: 1.40,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.loginPage, (context) => false);
                },
                child: const Text(
                  'skip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    height: 1.50,
                    letterSpacing: 1.28,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
