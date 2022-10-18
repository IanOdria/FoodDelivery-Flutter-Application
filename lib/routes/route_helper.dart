import 'package:food_delivery/pages/food/restaurants.dart';
import 'package:food_delivery/pages/food/popular_food.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/route_manager.dart';

class RouteHelper {
  static const String initial = "/initial";
  static const String restaurants = "/restaurants";
  static const String popularFood = "/popular-food";

  static String getInitial() => '$initial';
  static String getPopularFood(int pageID, int productID) =>
      '$popularFood?pageID=$pageID&productID=$productID';

  static String getRestaurants(int pageID) => '$restaurants?pageID=$pageID';

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      transition: Transition.cupertinoDialog,
      page: () => main_food_page(),
    ),
    GetPage(
      name: restaurants,
      transition: Transition.cupertinoDialog,
      page: () {
        var pageID = Get.parameters['pageID'];
        return RestaurantsPage(pageID: int.parse(pageID!));
      },
    ),
    GetPage(
      name: popularFood,
      transition: Transition.cupertinoDialog,
      page: () {
        var pageID = Get.parameters['pageID'];
        var productID = Get.parameters['productID'];
        return PopularFood(
          pageID: int.parse(pageID!),
          productID: int.parse(productID!),
        );
      },
    ),
  ];
}
