import 'package:flutter/material.dart';
import 'package:yarvolley_app/appearance/theme/images.dart';
import 'package:yarvolley_app/appearance/widgets/common_app_bar.dart';
// import 'package:yarvolley_app/appearance/widgets/main_page_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(title: "YARVOLLEY"),
      body: Center(child: noLogoIcon),
    );
  }
}
