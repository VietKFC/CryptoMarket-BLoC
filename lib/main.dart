import 'package:flutter/material.dart';
import 'package:vn_crypto/di/dependency_injection.dart';
import 'package:vn_crypto/ui/components/BottomNav.dart';
import 'package:vn_crypto/ui/screen/ListCoinScreen.dart';

void main() async {
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(color: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            Center(child: Text('Home')),
            ListCoinScreen(),
            Center(child: Text('Invest')),
            Center(child: Text('Settings'))
          ],
        ),
        bottomNavigationBar: BottomNav(
          onTap: (int i) {
            setState(() {
              _selectedIndex = i;
            });
          },
          selectedIndex: _selectedIndex,
        ));
  }
}
