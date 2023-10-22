import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/screens/cart.dart';
import 'package:store/screens/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:store/screens/favourites.dart';
import 'package:store/screens/login_page.dart';
import 'package:store/screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(
    GetMaterialApp(
      home: token != null ? MainPage() : LoginPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CartController cartController = Get.put(CartController());
  int selectedIndex = 0;
  bool isSearch = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(isSearch: isSearch),
      FavouritesPage(),
      CartPage(),
      SettingsPage()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Icon(
          Icons.shop,
          color: Colors.black,
          size: 30,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
        elevation: 0,
        
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: GNav(
        haptic: true, // haptic feedback
        tabBorderRadius: 20,
        tabBackgroundColor: Color.fromARGB(174, 66, 66, 66),
        selectedIndex: selectedIndex,
        gap: 8,
        iconSize: 24,
        backgroundColor: Colors.grey.shade900,
        color: Colors.white,
        activeColor: Colors.white,
        tabMargin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        onTabChange: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Favorites',
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart ' + cartController.count.toString(),
          ),
          GButton(
            icon: Icons.settings,
            text: 'Profile',
          )
        ],
      ),
    );
  }
}
