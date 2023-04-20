// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:maanstore/const/hardcoded_text.dart';
import 'package:maanstore/screens/Auth_Screen/auth_screen_1.dart';
import 'package:maanstore/screens/order_screen/my_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/constants.dart';
import '../../const/hardcoded_text_arabic.dart';
import '../cart_screen/cart_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../search_product_screen.dart';
import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  int customerId = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> checkId() async {
    final prefs = await SharedPreferences.getInstance();
    customerId = prefs.getInt('customerId')!;
  }

  @override
  void initState() {
    checkId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            const HomeScreen(),
            const SearchProductScreen(),
            const CartScreen(),
            customerId != 0 ? const MyOrderScreen() : const AuthScreen(),
            customerId != 0 ? const ProfileScreen() : const AuthScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(IconlyLight.home),

              label:isRtl ? HardcodedTextArabic.home : HardcodedTextEng.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(IconlyLight.search),
              label: isRtl ? HardcodedTextArabic.search : HardcodedTextEng.search,
            ),
            BottomNavigationBarItem(
              icon: const Icon(IconlyLight.bag),
              label: isRtl ? HardcodedTextArabic.cart : HardcodedTextEng.cart,
            ),
            BottomNavigationBarItem(
              icon: const Icon(IconlyLight.document),
              label: isRtl ? HardcodedTextArabic.orders : HardcodedTextEng.orders,
            ),
            BottomNavigationBarItem(
              icon: const Icon(IconlyLight.profile),
              label: isRtl ? HardcodedTextArabic.profile : HardcodedTextEng.profile,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: textColors,
          unselectedLabelStyle: const TextStyle(color: textColors),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
