import 'package:cresce_vendas_app_v1/models/discount.dart';
import 'package:cresce_vendas_app_v1/models/product.dart';
import 'package:cresce_vendas_app_v1/screens/splash_screen.dart';
import 'package:cresce_vendas_app_v1/screens/discount_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(DiscountAdapter());
  await Hive.openBox<Product>('products');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discount App',
      theme: ThemeData(
        fontFamily: 'Rubik',
        primaryColor: const Color(0xFF007FBA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007FBA),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge:
              TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF565656)),
          bodyMedium:
              TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF403E43)),
          titleLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF403E43)),
          labelSmall: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => DiscountListScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/svg/logo.svg',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
