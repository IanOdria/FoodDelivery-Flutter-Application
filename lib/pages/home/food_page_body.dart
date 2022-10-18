// Creación y manejo del Scroll

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/icon_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);
  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  // Page controller para mostrar una parte de los otros items en el scroll
  PageController pageController = PageController(viewportFraction: .85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue =
            pageController.page!; // obtener page value (en que "pagina" estan)
      });
    });
  }

  @override
  // Cuando salgas de la pagina borra la memoria para no acumular
  void dispose() {
    pageController.dispose();
  }

  // Body Widget return
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider Section
        Container(
          height: Dimentions.pageViewMainContainer,
          child: FutureBuilder(
            future: fetchRestaurants(context),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return PageView.builder(
                  controller: pageController,
                  itemCount: 5,
                  // position is index
                  itemBuilder: (BuildContext context, int index) {
                    // Data from json
                    Restaurants restaurant = snapshot.data[index];
                    return _buildPageItem(index, restaurant);
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),

        // Dots
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeColor: AppColors.mainColor,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        // Text Title (Popular)
        SizedBox(height: Dimentions.pixels30),
        Container(
          margin: EdgeInsets.only(left: Dimentions.pixels30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Popular'),
              SizedBox(width: Dimentions.pixels10),
              SmallText(text: 'Restaurants'),
            ],
          ),
        ),
        SizedBox(height: Dimentions.pixels15),

        // List food
        FutureBuilder(
          future: fetchRestaurants(context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Restaurants restaurant = snapshot.data[index];
                    // each list element
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRestaurants(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimentions.pixels20,
                          right: Dimentions.pixels20,
                          bottom: Dimentions.pixels10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.pixels20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFe8e8e8),
                                blurRadius: 6.0, // difumina
                                offset: Offset(0,
                                    4)), // mueve la posicion en y = 5 pixeles
                          ],
                        ),
                        child: Row(
                          children: [
                            // Image
                            Container(
                              width: Dimentions.img120,
                              height: Dimentions.img120,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.pixels20),
                                color: Colors.black,
                                image: DecorationImage(
                                  image: AssetImage(restaurant.img),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Info Container
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimentions.pixels15,
                                    right: Dimentions.pixels20,
                                    top: Dimentions.pixels5,
                                    bottom: Dimentions.pixels5,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        restaurant.restaurantName,
                                        style: TextStyle(
                                          fontSize: Dimentions.pixels18,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: .2,
                                        ),
                                      ),
                                      SizedBox(height: Dimentions.pixels10),
                                      SmallText(text: restaurant.description),
                                      SizedBox(height: Dimentions.pixels10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconTextWidget(
                                            icon: Icons.circle_sharp,
                                            text: restaurant.availability,
                                            iconColor: AppColors.iconColor1,
                                          ),
                                          IconTextWidget(
                                            icon: Icons.location_on,
                                            text:
                                                restaurant.distance.toString() +
                                                    ' km',
                                            iconColor: AppColors.mainColor,
                                          ),
                                          IconTextWidget(
                                            icon: Icons.access_time_rounded,
                                            text: restaurant.time.toString() +
                                                ' mins',
                                            iconColor: AppColors.iconColor2,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
      ],
    );
  }

  // Funcion que regresa un widget que constituye cada elemento en el scroll
  Widget _buildPageItem(int index, Restaurants restaurant) {
    // Scalling for Widget
    Matrix4 matrix = Matrix4.identity();

    if (index == _currPageValue.floor()) {
      // Widget centro
      var currScale =
          1 - (_currPageValue - index) * (1 - _scaleFactor); // Tamaño
      var currTrans = _height * (1 - currScale) / 2; // Posicion
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index >= _currPageValue.floor() + 1) {
      // Widget derecha
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index <= _currPageValue.floor() - 1) {
      // Widget izquierda
      var currScale =
          1 - (_currPageValue - index) * (1 - _scaleFactor); // Tamaño
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    // Elementos Scroll
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getRestaurants(index));
        },
        child: Stack(
          children: [
            // Imagen
            Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.pixels10, right: Dimentions.pixels10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                  image: DecorationImage(
                    image: AssetImage(restaurant.img),
                    fit: BoxFit.cover,
                  )),
            ),
            // Contenedor Info
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimentions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimentions.pixels30,
                    right: Dimentions.pixels30,
                    bottom: Dimentions.pixels30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0, // difumina
                        offset:
                            Offset(0, 5)), // mueve la posicion en y = 5 pixeles
                  ],
                ),
                // Container para poder poner el padding
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimentions.height15,
                      left: Dimentions.pixels20,
                      right: Dimentions.pixels20),
                  child: AppColumn(
                    text: restaurant.restaurantName,
                    size: Dimentions.pixels20,
                    available: restaurant.availability,
                    distance: restaurant.distance,
                    minutes: restaurant.time,
                    stars: restaurant.stars,
                    comments: restaurant.comments,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
