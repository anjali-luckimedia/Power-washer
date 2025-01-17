import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/home_data/home_data_bloc.dart';
import 'package:power_washer/repositary/api_repositary.dart';
import 'package:power_washer/screen/auth_screen/login_screen.dart';
import 'package:power_washer/screen/auth_screen/otp_screen.dart';
import 'package:power_washer/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  final ApiService apiService = ApiService(); // Create an instance of ApiService

  runApp(MultiProvider(providers: [
    BlocProvider(
      create: (context) => HomePageBloc(apiService),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}

