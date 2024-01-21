import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/bloc/products/products_bloc.dart';
import 'package:qr_code/models/product_model.dart';
import 'package:qr_code/routes/route.dart';
import 'package:qr_code/widgets/appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsBloc product = context.read<ProductsBloc>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Products'),
      body: StreamBuilder(
        stream: product.streamProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to get all products \n${snapshot.error.toString()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? true)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No Products Found',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: ElevatedButton(
                      onPressed: () => context.go('/products/add'),
                      child: const Text(
                        'Add Product',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          List<Product> products = [];

          for (var product in snapshot.data!.docs) {
            products.add(product.data());
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final Product product = products[index];

              return ListTile(
                tileColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 16,
                ),
                title: Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('Rp. ${product.price.toString()}'),
                trailing: QrImageView(
                  data: product.productCode,
                  version: QrVersions.auto,
                ),
                onTap: () {
                  context.read<ProductsBloc>().add(
                      ProductsEventGetOne(productCode: product.productCode));

                  context.goNamed(
                    RouteName.detailProducts,
                    pathParameters: {
                      'productId': product.productId!,
                    },
                    // extra: product,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
