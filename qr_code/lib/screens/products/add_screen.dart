import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code/bloc/products/products_bloc.dart';
import 'package:qr_code/models/product_model.dart';

import '../../widgets/appbar.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _productName = TextEditingController();
  late final TextEditingController _productPrice = TextEditingController();
  late final TextEditingController _productQuantity = TextEditingController();
  late final TextEditingController _productCode = TextEditingController();
  late final TextEditingController _productDescription =
      TextEditingController();

  // @override
  // void initState() {
  //   _formKey = GlobalKey<FormState>();
  //   _productName = TextEditingController();
  //   _productDescription = TextEditingController();
  //   _productPrice = TextEditingController();
  //   _productQuantity = TextEditingController();
  //   _productCode = TextEditingController();

  //   super.initState();
  // }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _productName.dispose();
    _productDescription.dispose();
    _productPrice.dispose();
    _productQuantity.dispose();
    _productCode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Product'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                controller: _productCode,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: 'Code',
                ),
                validator: (value) {
                  return value!.length < 10
                      ? 'code is required and cannot less than 8 characters'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _productDescription,
                minLines: 5,
                maxLines: 10,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 40),
              BlocConsumer<ProductsBloc, ProductsState>(
                listener: (context, state) {
                  if (state is ProductsStateErrorAdd) {
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

                  if (state is ProductsStateCompleteAdd) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Success add product ${_productName.text}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );

                    context.pushReplacement('/');
                  }
                },
                builder: (context, state) => SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (state is! ProductsStateLoadingAdd &&
                          (_formKey.currentState?.validate() ?? false)) {
                        BlocProvider.of<ProductsBloc>(context).add(
                          ProductsEventAdd(
                            product: Product(
                              name: _productName.text,
                              price: int.parse(_productPrice.text),
                              quantity: int.parse(_productQuantity.text),
                              productCode: _productCode.text,
                              description: _productDescription.text,
                            ),
                          ),
                        );
                      }

                      // context.read<ProductsBloc>().add(event)
                    },
                    child: state is ProductsStateLoadingAdd
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
