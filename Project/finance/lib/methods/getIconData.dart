import 'package:flutter/material.dart';

IconData getIconData(String categoryName) {
  if (categoryName == "Salary") {
    return Icons.attach_money;
  } else if (categoryName == "Stocks") {
    return Icons.add_to_home_screen_sharp;
  } else if (categoryName == "Family") {
    return Icons.people;
  } else if (categoryName == "Entertainment") {
    return Icons.gamepad;
  } else if (categoryName == "Food") {
    return Icons.emoji_food_beverage_rounded;
  } else if (categoryName == "Grocery") {
    return Icons.local_grocery_store;
  } else if (categoryName == "Transportation") {
    return Icons.emoji_transportation;
  } else if (categoryName == "Friends") {
    return Icons.person_sharp;
  } else if (categoryName == "Rent") {
    return Icons.home_filled;
  }
  return Icons.attach_money;
}
