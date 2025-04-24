// import 'package:card_master/features/themes/provider/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ThemeChangerPage extends StatelessWidget {
//   const ThemeChangerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Theme Settings')),
//       body: ListView(
//         children: [
//           ListTile(
//             title: const Text('Light Theme'),
//             leading: const Icon(Icons.light_mode),
//             onTap: () {
//               themeProvider.setThemeMode(ThemeMode.light);
//             },
//           ),
//           ListTile(
//             title: const Text('Dark Theme'),
//             leading: const Icon(Icons.dark_mode),
//             onTap: () {
//               themeProvider.setThemeMode(ThemeMode.dark);
//             },
//           ),
//           ListTile(
//             title: const Text('System Default'),
//             leading: const Icon(Icons.phone_android),
//             onTap: () {
//               themeProvider.setThemeMode(ThemeMode.system);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:card_master/features/themes/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChangerPage extends StatelessWidget {
  const ThemeChangerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your theme',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Select your preferred appearance',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _ThemeOptionCard(
                    title: 'Light Theme',
                    icon: Icons.light_mode,
                    isSelected: themeProvider.themeMode == ThemeMode.light,
                    onTap: () => themeProvider.setThemeMode(ThemeMode.light),
                    color: Colors.blue.shade100,
                    iconColor: Colors.amber.shade700,
                  ),
                  const SizedBox(height: 12),
                  _ThemeOptionCard(
                    title: 'Dark Theme',
                    icon: Icons.dark_mode,
                    isSelected: themeProvider.themeMode == ThemeMode.dark,
                    onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
                    color: Colors.grey.shade800,
                    iconColor: Colors.blue.shade200,
                  ),
                  const SizedBox(height: 12),
                  _ThemeOptionCard(
                    title: 'System Default',
                    icon: Icons.phone_android,
                    isSelected: themeProvider.themeMode == ThemeMode.system,
                    onTap: () => themeProvider.setThemeMode(ThemeMode.system),
                    color:
                        isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                    iconColor:
                        isDarkMode
                            ? Colors.green.shade300
                            : Colors.green.shade700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;

  const _ThemeOptionCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isSelected
                ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
                : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 28, color: iconColor),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
