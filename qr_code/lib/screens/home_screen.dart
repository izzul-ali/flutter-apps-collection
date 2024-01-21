import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/routes/route.dart';
import 'package:qr_code/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> services = [
    {
      'name': RouteName.addProducts,
      'title': 'Add Product',
      'icon': Icons.add_business_outlined,
    },
    {
      'name': RouteName.products,
      'title': 'Products',
      'icon': Icons.list_alt,
    },
    {
      'name': RouteName.scanProducts,
      'title': 'Scan Product',
      'icon': Icons.qr_code_scanner,
    },
    {
      'name': RouteName.home,
      'title': 'Document PDF',
      'icon': Icons.document_scanner_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'QRCODE'),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: services.length,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) => Material(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              debugPrint('route ${services[index]['name']}');
              context.goNamed(services[index]['name']);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  services[index]['icon'] ?? Icons.warning_amber_rounded,
                  size: 40,
                ),
                const SizedBox(height: 15),
                Text(
                  services[index]['title'] ?? '-',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
