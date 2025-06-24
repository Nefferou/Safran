import 'package:flutter/material.dart';
import 'package:safran/widgets/pages/setings_page/settings_page.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {

  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => SettingsPage(),
                ),
              );
            },
            icon: Icon(Icons.settings)
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}