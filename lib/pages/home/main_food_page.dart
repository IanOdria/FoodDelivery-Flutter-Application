// Main Page

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class main_food_page extends StatefulWidget {
  const main_food_page({Key? key}) : super(key: key);

  @override
  State<main_food_page> createState() => _main_food_pageState();
}

class _main_food_pageState extends State<main_food_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimentions.pixels50, bottom: Dimentions.pixels15),
              padding: EdgeInsets.only(
                  left: Dimentions.pixels20, right: Dimentions.pixels20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Data country and city
                  Column(
                    children: [
                      BigText(text: 'Mexico', color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: 'Guadalajara', color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ],
                  ),
                  // Search button
                  Center(
                    child: Container(
                      width: Dimentions.pixels45,
                      height: Dimentions.pixels45,
                      child: Icon(Icons.search,
                          color: Colors.white, size: Dimentions.icon24),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.pixels15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Body
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),

          // Navigation Bar
          /*
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: AppColors.signColor,
            selectedFontSize: Dimentions.pixels10,
            unselectedFontSize: Dimentions.pixels10,
            iconSize: Dimentions.pixels25,
            onTap: (value) {
              // Respond to item press.
            },
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'History',
                icon: Icon(Icons.access_alarm),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle_rounded),
              ),
            ],
          )
       */
        ],
      ),
    );
  }
}
