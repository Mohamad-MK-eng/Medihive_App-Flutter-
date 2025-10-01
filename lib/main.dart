import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/constant/Colors&Fonts.dart';
import 'package:medihive_1_/pages/Auth/cubit/auth_cubit_cubit.dart';
import 'package:medihive_1_/helper/Routes.dart';
import 'package:medihive_1_/cubits/Profile_Cubit/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Medihive());
}

class Medihive extends StatelessWidget {
  Medihive({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (_) => ProfileCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            drawerTheme: DrawerThemeData(
                backgroundColor: Colors.white,
                scrimColor: Colors.transparent,
                shadowColor: Colors.black,
                surfaceTintColor: mintGreen,
                width: MediaQuery.of(context).size.width / 1.7),
            appBarTheme: AppBarTheme(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                centerTitle: true,
                titleTextStyle: TextStyle(
                    color: hardmintGreen,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    fontSize: 20))),

        onGenerateRoute: Routes.onGernerateRoute,
        // onGenerateRoute: Routes.onGernerateRoute,
        // أول شاشة بتظهر
        initialRoute: Routes.ipPage,
      ),
    );
  }
}
