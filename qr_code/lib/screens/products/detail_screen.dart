import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/widgets/appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../bloc/products/products_bloc.dart';

class DetailProductScreen extends StatelessWidget {
  DetailProductScreen({
    super.key,
    required this.productId,
    // required this.product,
  });

  final String productId;
  // final Product product;

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _productName = TextEditingController();
  late final TextEditingController _productPrice = TextEditingController();
  late final TextEditingController _productQuantity = TextEditingController();
  late final TextEditingController _productCode = TextEditingController();
  late final TextEditingController _productDescription =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Detail Product'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsStateLoadingGetOne) {
              debugPrint('LOADING BOSSS');

              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductsStateErrorGetOne) {
              return Center(
                child: Text(
                  'Failed to get one product \n${state.message}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            if (state is ProductsStateCompleteGetOne) {
              _productName.text = state.product.name;
              _productPrice.text = state.product.price.toString();
              _productQuantity.text = state.product.quantity.toString();
              _productCode.text = state.product.productCode;
              _productDescription.text = state.product.description ?? '';
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  QrImageView(data: _productCode.text, size: 170),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _productCode,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: 'Code',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _productName,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      return value!.length < 4
                          ? 'characters must be greater than 3'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _productPrice,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    validator: (value) {
                      return value!.isEmpty || int.parse(value) < 1000
                          ? 'price is required and must be greater than 1000'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _productQuantity,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    validator: (value) {
                      return value!.isEmpty || int.parse(value) < 1
                          ? 'quantity is required and cannot less than 1'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    minLines: 5,
                    maxLines: 10,
                    controller: _productDescription,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<ProductsBloc, ProductsState>(
                    listener: (context, state) {
                      if (state is ProductsStateErrorUpdate) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'ERROR: ${state.message}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }

                      if (state is ProductsStateCompleteUpdate) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Success update product ${_productName.text}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );

                        context.pop();
                      }
                    },
                    builder: (context, state) => SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (state is! ProductsStateLoadingUpdate &&
                              (_formKey.currentState?.validate() ?? false)) {
                            BlocProvider.of<ProductsBloc>(context).add(
                              ProductsEventUpdate(
                                productId: productId,
                                name: _productName.text,
                                price: int.parse(_productPrice.text),
                                quantity: int.parse(_productQuantity.text),
                                description: _productDescription.text,
                              ),
                            );
                          }

                          // context.read<ProductsBloc>().add(event)
                        },
                        child: state is ProductsStateLoadingUpdate
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Update',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<ProductsBloc, ProductsState>(
                    listener: (context, state) {
                      if (state is ProductsStateErrorDelete) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'ERROR: ${state.message}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }

                      if (state is ProductsStateCompleteDelete) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Success delete product ${_productName.text}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );

                        context.pop();
                      }
                    },
                    builder: (context, state) => SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[50],
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (state is! ProductsStateLoadingDelete &&
                              (_formKey.currentState?.validate() ?? false)) {
                            BlocProvider.of<ProductsBloc>(context)
                                .add(ProductsEventDelete(productId: productId));
                          }

                          // context.read<ProductsBloc>().add(event)
                        },
                        child: state is ProductsStateLoadingDelete
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
