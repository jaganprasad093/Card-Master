import 'package:card_master/features/themes/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChangerPage extends StatelessWidget {
  const ThemeChangerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Light Theme'),
            leading: const Icon(Icons.light_mode),
            onTap: () {
              themeProvider.setThemeMode(ThemeMode.light);
            },
          ),
          ListTile(
            title: const Text('Dark Theme'),
            leading: const Icon(Icons.dark_mode),
            onTap: () {
              themeProvider.setThemeMode(ThemeMode.dark);
            },
          ),
          ListTile(
            title: const Text('System Default'),
            leading: const Icon(Icons.phone_android),
            onTap: () {
              themeProvider.setThemeMode(ThemeMode.system);
            },
          ),
        ],
      ),
    );
  }
}
