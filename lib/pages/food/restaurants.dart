import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/return_icon.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:get/get.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/models/restaurant_model.dart';

class RestaurantsPage extends StatefulWidget {
  final int pageID;

  const RestaurantsPage({
    Key? key,
    required this.pageID,
  }) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  // Back para que el texto aparezca hasta hacer scroll
  ScrollController _scrollController = ScrollController();
  bool lastStatus = true;

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (Dimentions.pixels250 - kToolbarHeight);
  }

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  @override
  void initState() {
    //_scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchRestaurants(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // variable que contiene restaurantes
            Restaurants restaurants = snapshot.data[widget.pageID];
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Header - Imagen, titulo e iconos
                SliverAppBar(
                  // Icons
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getInitial());
                            // Resetear el stack
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/initial', (Route<dynamic> route) => false);
                          },
                          child: ReturnIcon(icon: Icons.arrow_back_ios_new)),
                      ReturnIcon(icon: Icons.shopping_cart_outlined),
                    ],
                  ),
                  pinned: true,
                  backgroundColor: AppColors.yellowColor,
                  expandedHeight: Dimentions.pixels250,

                  flexibleSpace: FlexibleSpaceBar(
                    expandedTitleScale: 1,
                    title: Text(
                      restaurants.restaurantName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: .2,
                          color: isShrink ? Colors.white : Colors.transparent),
                    ),
                    background: Image.asset(
                      restaurants.img,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Body - Info y Food list
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // Info restaurante
                        Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                ),
                            margin: EdgeInsets.only(
                              left: Dimentions.pixels30,
                              right: Dimentions.pixels30,
                              bottom: Dimentions.pixels20,
                              top: Dimentions.pixels30,
                            ),
                            child: AppColumn(
                              text: restaurants.restaurantName,
                              size: Dimentions.pixels25,
                              available: restaurants.availability,
                              distance: restaurants.distance,
                              minutes: restaurants.time,
                              stars: restaurants.stars,
                              comments: restaurants.comments,
                            )),
                        // Division
                        Divider(
                          color: Color(0xFFccc7c5),
                          height: Dimentions.pixels5,
                          thickness: .4,
                          indent: Dimentions.pixels15,
                          endIndent: Dimentions.pixels15,
                        ),
                        SizedBox(height: Dimentions.pixels20),
                        // Food list
                        Container(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                //llamo id del restaurante
                                Product product = restaurants.products[index];
                                // each list element
                                return _MenuList(product, index);
                              },
                            ),
                          ),
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
    );
  }

  // Widget que regresa lista de el Menu
  Widget _MenuList(Product product, int index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getPopularFood(widget.pageID, index));
      },
      child: Container(
        margin: EdgeInsets.only(
          left: Dimentions.pixels20,
          right: Dimentions.pixels20,
          bottom: Dimentions.pixels10,
        ),
        padding: EdgeInsets.only(right: Dimentions.pixels10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimentions.pixels20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xFFe8e8e8),
                blurRadius: 6.0, // difumina
                offset: Offset(0, 4)), // mueve la posicion en y = 5 pixeles
          ],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: Dimentions.img120,
              height: Dimentions.img120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.pixels20),
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage(product.img),
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
                    top: Dimentions.pixels10,
                    bottom: Dimentions.pixels10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: Dimentions.pixels18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: .2,
                        ),
                      ),
                      SizedBox(height: Dimentions.pixels5),
                      SmallText(text: product.description),
                      SizedBox(height: Dimentions.pixels10),
                      Text(
                        '\$' + product.price.toString(),
                        style: TextStyle(
                          fontSize: Dimentions.pixels15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .2,
                          color: AppColors.titleColor,
                        ),
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
  }
}
