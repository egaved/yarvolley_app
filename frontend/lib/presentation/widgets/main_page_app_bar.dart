import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainPageAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontFamily: 'AppLogoFont', color: Colors.white),
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
