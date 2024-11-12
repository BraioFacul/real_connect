import 'package:flutter/material.dart';
import 'package:real_connect/login.dart';

double iconSize = 32;
Color cardColor = Colors.white;
BoxShadow boxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.24),
  spreadRadius: 0,
  blurRadius: 8,
  offset: Offset(0, 3),
);

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          iconSize: iconSize,
          onPressed: () {},
          icon: Stack(
            children: [
              Positioned(
                top: 2,
                left: 2,
                child: Icon(
                  Icons.settings,
                  color: Colors.black.withOpacity(0.4),
                  size: iconSize,
                ),
              ),
              Icon(
                Icons.settings,
                color: cardColor,
                size: iconSize,
              ),
            ],
          ),
        ),
        IconButton(
          iconSize: iconSize,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
           },
          icon: Stack(
            children: [
              Positioned(
                top: 2,
                left: 2,
                child: Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.black.withOpacity(0.4),
                  size: iconSize,
                ),
              ),
              Icon(
                Icons.exit_to_app_rounded,
                color: cardColor,
                size: iconSize,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
