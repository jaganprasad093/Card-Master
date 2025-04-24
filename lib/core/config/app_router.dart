import 'package:card_master/features/bottomnavigation/bottomnavigtion.dart';
import 'package:card_master/features/home_page/presentation/pages/bank_master_page.dart';
import 'package:card_master/features/home_page/presentation/pages/credit_card_master.dart';
import 'package:card_master/features/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash', // Set initial route
    errorBuilder: (context, state) => const BottomNavigation(initialIndex: 2),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: 'bottomnavigation/:initialIndex',
            builder: (context, state) {
              final initialIndex = int.parse(
                state.pathParameters['initialIndex']!,
              );
              return BottomNavigation(initialIndex: initialIndex);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/bankmaster',
        builder: (context, state) => const BankMasterPage(),
      ),
      GoRoute(
        path: '/creditcardmaster',
        builder: (context, state) => const CreditCardMaster(),
      ),
    ],
  );
}
