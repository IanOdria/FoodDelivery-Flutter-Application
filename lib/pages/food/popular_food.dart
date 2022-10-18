// Foods page

import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/return_icon.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:get/get.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/models/restaurant_model.dart';

class PopularFood extends StatefulWidget {
  final int pageID;
  final int productID;

  const PopularFood({
    Key? key,
    required this.pageID,
    required this.productID,
  }) : super(key: key);

  @override
  State<PopularFood> createState() => _PopularFoodState();
}

class _PopularFoodState extends State<PopularFood> {
  var quantity = 1;

  void addQuantity() {
    setState(() {
      quantity += 1;
    });
  }

  void subsQuantity() {
    setState(() {
      quantity -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: fetchRestaurants(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // variable que contiene info restaurantes
            Restaurants restaurants = snapshot.data[widget.pageID];
            Product product = restaurants.products[widget.productID];
            return Stack(
              children: [
                // Image
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: Dimentions.img350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(product.img),
                      ),
                    ),
                  ),
                ),
                // Icons
                Positioned(
                  left: Dimentions.pixels20,
                  right: Dimentions.pixels20,
                  top: Dimentions.pixels60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getRestaurants(widget.pageID));
                          },
                          child: ReturnIcon(icon: Icons.arrow_back_ios_new)),
                      ReturnIcon(icon: Icons.shopping_cart_outlined),
                    ],
                  ),
                ),
                // Information
                Positioned(
                  // posicion en stack
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: Dimentions.img350 -
                      Dimentions.pixels40, //empieza desde la imagen
                  child: Container(
                    // padding
                    padding: EdgeInsets.only(
                        left: Dimentions.pixels30,
                        right: Dimentions.pixels30,
                        top: Dimentions.pixels30),
                    decoration: BoxDecoration(
                      // formato
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimentions.pixels50),
                        topLeft: Radius.circular(Dimentions.pixels50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimentions.pixels10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: product.name,
                                    size: 25,
                                  ),
                                  SizedBox(height: Dimentions.pixels5),
                                  SmallText(text: product.type),
                                ],
                              ),
                              BigText(
                                text: '\$' + product.price.toString(),
                                size: 25,
                              ),
                            ]),

                        SizedBox(height: Dimentions.pixels20),
                        Divider(
                          color: Color(0xFFccc7c5),
                          // height: Dimentions.pixels5,
                          thickness: .4,
                          indent: Dimentions.pixels10,
                          endIndent: Dimentions.pixels10,
                        ),
                        SizedBox(height: Dimentions.pixels20),

                        // Nombre y datos
                        AppColumn(
                          text: restaurants.restaurantName,
                          size: 20,
                          available: restaurants.availability,
                          distance: restaurants.distance,
                          minutes: restaurants.time,
                          stars: restaurants.stars,
                          comments: restaurants.comments,
                        ),

                        SizedBox(height: Dimentions.pixels20),
                        Divider(
                          color: Color(0xFFccc7c5),
                          // height: Dimentions.pixels5,
                          thickness: .4,
                          indent: Dimentions.pixels10,
                          endIndent: Dimentions.pixels10,
                        ),
                        SizedBox(height: Dimentions.pixels20),

                        // Information
                        BigText(text: 'Information'),
                        SizedBox(height: Dimentions.pixels15),
                        SmallText(
                          text: product.description,
                          size: Dimentions.pixels18,
                          //color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      //buttons add
      bottomNavigationBar: Container(
        height: Dimentions.img120,
        padding: EdgeInsets.only(
          top: Dimentions.pixels20,
          bottom: Dimentions.pixels40,
          left: Dimentions.pixels30,
          right: Dimentions.pixels30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Boton izquierdo
            Container(
              padding: EdgeInsets.only(
                left: Dimentions.pixels15,
                right: Dimentions.pixels15,
              ),
              height: Dimentions.img120,
              width: Dimentions.pixels140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.pixels25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0, // difumina
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 3.0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // minus
                  InkWell(
                    onTap: () {
                      if (quantity > 1) {
                        subsQuantity();
                      }
                    },
                    child: Container(
                      height: Dimentions.pixels35,
                      width: Dimentions.pixels35,
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.pixels50),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimentions.pixels10 / 2),
                  BigText(
                    text: quantity.toString(),
                    color: Colors.black,
                    size: Dimentions.pixels25,
                  ),
                  SizedBox(width: Dimentions.pixels10 / 2),
                  // plus
                  GestureDetector(
                    onTap: () {
                      addQuantity();
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Boton derecho
            Container(
              height: Dimentions.img120,
              width: Dimentions.pixels200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.pixels25),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: BigText(
                  text: 'Add to cart',
                  color: Colors.white,
                  size: Dimentions.pixels20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
