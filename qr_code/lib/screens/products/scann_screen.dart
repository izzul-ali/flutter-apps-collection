import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code/bloc/products/products_bloc.dart';
import 'package:qr_code/routes/route.dart';
import 'package:qr_code/widgets/appbar.dart';

class ScanProductScreen extends StatelessWidget {
  const ScanProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan Product'),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          // returnImage: true,
        ),
        onDetect: (barcodes) {
          final List<Barcode> barcodeValue = barcodes.barcodes;
          // final Uint8List? image = barcodes.image;

          if (barcodeValue[0].rawValue != null) {
            debugPrint('barcode data ${barcodeValue[0].rawValue}');

            context.read<ProductsBloc>().add(ProductsEventGetOne(
                  productCode: barcodeValue[0].rawValue!,
                ));

            context.goNamed(
              RouteName.detailProducts,
              pathParameters: {
                'productId': barcodeValue[0].rawValue!,
              },
            );
          }
        },
      ),
    );
  }
}
