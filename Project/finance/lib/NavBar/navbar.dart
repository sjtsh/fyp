import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final boxShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 3,
        offset: const Offset(0, 2))
  ];
  final Function _setIndex;
  final int currentIndex;

  NavBar(this._setIndex, this.currentIndex, {Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, -2))
      ]),
      child: CustomNavigationBar(
        strokeColor: Colors.blue.withOpacity(0.5),
        iconSize: 25,
        currentIndex: widget.currentIndex,
        selectedColor: Colors.black,
        unSelectedColor: Colors.black.withOpacity(0.5),
        backgroundColor: Colors.white,
        opacity: 1,
        onTap: (int i) {
          widget._setIndex(i);
        },
        items: [
          CustomNavigationBarItem(
            icon: Icon(
              Icons.view_carousel_sharp,
              color: widget.currentIndex == 0
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(
                  color: widget.currentIndex == 0
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              Icons.attach_money_outlined,
              color: widget.currentIndex == 1
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  color: widget.currentIndex == 1
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              Icons.money_outlined,
              color: widget.currentIndex == 2
                  ? Colors.blue
                  : Colors.black.withOpacity(0.5),
            ),
            title: Text(
              "Transactions",
              style: TextStyle(
                  color: widget.currentIndex == 2
                      ? Colors.blue
                      : Colors.black.withOpacity(0.5),
                  fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
