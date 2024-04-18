import 'package:flutter/material.dart';

class AppBarM extends StatelessWidget implements PreferredSizeWidget {
  const AppBarM({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF04248b),
      title: const Text(
        "Protótipo Eureka",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

