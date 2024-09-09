import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/providers/cart_provider.dart';

import 'package:shop_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<Widget> pages = const [ProductList(), CartPage()];

  @override
  Widget build(BuildContext context) {
      int len=Provider.of<CartProvider>(context).cart.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      
        items: [
         const BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_filled,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: len!=0?'Item(s):$len':'Cart',

            icon: const Icon(
              
              Icons.shopping_cart_checkout,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
