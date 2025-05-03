import 'package:flutter/material.dart';
import 'package:yarvolley_app/appearance/theme/colors.dart';

class CommonPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonPageAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontFamily: 'AppCommonFont', color: Colors.white),
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
