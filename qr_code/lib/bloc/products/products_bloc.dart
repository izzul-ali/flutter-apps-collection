import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/models/product_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Product>> streamProducts() async* {
    yield* instance
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  ProductsBloc() : super(ProductsStateInitial()) {
    on<ProductsEventAdd>(_onAddProduct);
    on<ProductsEventUpdate>(_onUpdateProduct);
    on<ProductsEventDelete>(_onDeleteProduct);
    on<ProductsEventGetOne>(_onGetOneProduct);
  }

  _onGetOneProduct(
      ProductsEventGetOne event, Emitter<ProductsState> emit) async {
    try {
      emit(ProductsStateLoadingGetOne());

      final result = await instance
          .collection('products')
          .where('productCode', isEqualTo: event.productCode)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          return null;
        }

        return value.docs[0].data();
      });

      if (result != null) {
        final Product product = Product.fromJson(result);

        emit(ProductsStateCompleteGetOne(
          product: product,
        ));

        return;
      }

      emit(const ProductsStateErrorGetOne(message: 'Product not found'));
    } on FirebaseException catch (e) {
      debugPrint('firebase error ${e.message}');

      emit(ProductsStateErrorGetOne(message: e.toString()));
    } catch (e) {
      debugPrint('error ${e.toString()}');

      emit(ProductsStateErrorGetOne(message: e.toString()));
    }
  }

  _onAddProduct(ProductsEventAdd event, Emitter<ProductsState> emit) async {
    try {
      emit(ProductsStateLoadingAdd());

      final result =
          await instance.collection('products').add(event.product.toJson());

      await instance.collection('products').doc(result.id).update({
        "productId": result.id,
      });

      emit(const ProductsStateCompleteAdd());
    } on FirebaseException catch (e) {
      debugPrint('firebase error ${e.message}');

      emit(ProductsStateErrorAdd(message: e.toString()));
    } catch (e) {
      debugPrint('error ${e.toString()}');

      emit(ProductsStateErrorAdd(message: e.toString()));
    }
  }

  _onUpdateProduct(
      ProductsEventUpdate event, Emitter<ProductsState> emit) async {
    try {
      emit(ProductsStateLoadingUpdate());

      await instance.collection('products').doc(event.productId).update({
        'name': event.name,
        'price': event.price,
        'quantity': event.quantity,
        'description': event.description,
      });

      emit(ProductsStateCompleteUpdate());
    } on FirebaseException catch (e) {
      debugPrint('firebase error ${e.message}');

      emit(ProductsStateErrorUpdate(message: e.toString()));
    } catch (e) {
      debugPrint('error ${e.toString()}');

      emit(ProductsStateErrorUpdate(message: e.toString()));
    }
  }

  _onDeleteProduct(
      ProductsEventDelete event, Emitter<ProductsState> emit) async {
    try {
      emit(ProductsStateLoadingDelete());

      await instance.collection('products').doc(event.productId).delete();

      emit(ProductsStateCompleteDelete());
    } on FirebaseException catch (e) {
      debugPrint('firebase error ${e.message}');

      emit(ProductsStateErrorDelete(message: e.toString()));
    } catch (e) {
      debugPrint('error ${e.toString()}');

      emit(ProductsStateErrorDelete(message: e.toString()));
    }
  }
}
