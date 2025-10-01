import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/AppDimensions.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/pages/Auth/widgets/AuthLogo.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
// مؤقتًا بدل الصفحة الرئيسية

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.linearToEaseOut)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 15,
      ),
    ]).animate(_controller);

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    _navigateAfterDelay(); // استدعاء التوجيه بعد بداية الأنيميشن
  }

  Future<void> _navigateAfterDelay() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isAuthorized') ?? false;
    final access_token = prefs.getString('token');
    final role_id = prefs.getInt('role_id');

    // وضع التوكن في bloc لسهولة استرجاعه
    if (access_token != null && isLoggedIn && role_id != null) {
      BlocProvider.of<AuthCubit>(context).access_token = access_token;
      BlocProvider.of<AuthCubit>(context).role_id = role_id;
    }

    await Future.delayed(const Duration(seconds: 3)); // إظهار الشعار قليلًا

    if (!mounted) return;

    if (access_token != null && isLoggedIn && role_id != null) {
      roleBasedNavigation(role_id);
    } else
      Navigator.pushNamed(
        // هون مفروض onboarding
        context,
        Routes.onBoardings,
      );

    //  Navigator.pushNamed(context, Routes.loginPage);
    //  Navigator.push(
    //  context, MaterialPageRoute(builder: (_) => ForgetPasswordPage()));
  }

  void roleBasedNavigation(int role_id) {
    if (role_id == 4) {
      // if patient
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.patientHome, (context) => false);
    } else if (role_id == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.doctor_home_page, (context) => false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Appdimensions.init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Authlogo(islogin: true),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
