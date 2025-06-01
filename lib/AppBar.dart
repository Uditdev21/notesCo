import 'package:flutter/material.dart';
import 'package:notesco/theme/theme_controller.dart';
import 'package:get/get.dart';

class GetAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String Title;
  const GetAppBar({super.key, required this.Title});

  @override
  State<GetAppBar> createState() => _GetAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GetAppBarState extends State<GetAppBar> {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('${widget.Title}',style: TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true,
      actions: [
        Obx(() {
          final isDark = themeController.isDarkMode;
          return IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white : Colors.black,
            ),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            onPressed: () => themeController.toggleTheme(),
          );
        })
      ],
    );
  }
}
