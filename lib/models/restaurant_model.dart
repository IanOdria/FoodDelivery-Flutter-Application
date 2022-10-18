// To parse this JSON data, do
//
//     final restaurants = restaurantsFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

List<Restaurants> restaurantsFromJson(String str) => List<Restaurants>.from(
    json.decode(str).map((x) => Restaurants.fromJson(x)));

// Process the data into a map
Future<List<Restaurants>> fetchRestaurants(BuildContext context) async {
  final jsonstring = await DefaultAssetBundle.of(context)
      .loadString('lib/models/json_data.json');
  return restaurantsFromJson(jsonstring);
}

class Restaurants {
  Restaurants({
    required this.id,
    required this.restaurantName,
    required this.description,
    required this.stars,
    required this.distance,
    required this.time,
    required this.img,
    required this.availability,
    required this.menuItems,
    required this.products,
    required this.comments,
  });

  int id;
  String restaurantName;
  String description;
  int stars;
  double distance;
  int time;
  String img;
  String availability;
  int comments;
  int menuItems;
  List<Product> products;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        restaurantName: json["restaurantName"],
        description: json["description"],
        stars: json["stars"],
        distance: json["distance"].toDouble(),
        time: json["time"],
        img: json["img"],
        availability: json["availability"],
        comments: json["comments"],
        menuItems: json["menu-items"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.img,
    required this.type,
    required this.typeId,
  });

  int id;
  String name;
  String description;
  int price;
  int stars;
  String img;
  String type;
  int typeId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stars: json["stars"],
        img: json["img"],
        type: json["type"],
        typeId: json["typeId"],
      );
}
