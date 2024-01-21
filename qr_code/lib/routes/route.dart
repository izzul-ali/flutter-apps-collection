import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../screens/products/scann_screen.dart';
import '../screens/products/detail_screen.dart';
import '../screens/products/add_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/error_screen.dart';
import '../screens/products/list_screen.dart';

part 'route_name.dart';

final GoRouter router = GoRouter(
  // redirect for detect user is authenticated or not
  redirect: (context, state) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return '/login';
    }

    return null;
  },
  // when route path is wrong
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: <RouteBase>[
    // if route in same level, navigate will replace
    GoRoute(
      path: '/',
      name: RouteName.home,
      builder: (context, state) => HomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'products',
          name: RouteName.products,
          builder: (context, state) => const ProductsScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: ':productId',
              name: RouteName.detailProducts,
              builder: (context, state) => DetailProductScreen(
                productId: state.pathParameters['productId']!,
                // product: state.extra as Product,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'products-add',
          name: RouteName.addProducts,
          builder: (context, state) => const AddProductScreen(),
        ),
        GoRoute(
          path: 'products-scan',
          name: RouteName.scanProducts,
          builder: (context, state) => const ScanProductScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
