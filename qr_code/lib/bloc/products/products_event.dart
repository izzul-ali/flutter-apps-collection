part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

final class ProductsEventFetch extends ProductsEvent {
  @override
  List<Object> get props => [];
}

final class ProductsEventGetOne extends ProductsEvent {
  final String productCode;

  const ProductsEventGetOne({required this.productCode});

  @override
  List<Object> get props => [productCode];
}

final class ProductsEventAdd extends ProductsEvent {
  final Product product;

  const ProductsEventAdd({required this.product});

  @override
  List<Object> get props => [product];
}

final class ProductsEventUpdate extends ProductsEvent {
  final String productId;
  final String name;
  final num price;
  final int quantity;
  final String? description;

  const ProductsEventUpdate({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.description,
  });

  @override
  List<Object> get props => [productId, name, price, quantity];
}

final class ProductsEventDelete extends ProductsEvent {
  final String productId;

  const ProductsEventDelete({required this.productId});

  @override
  List<Object> get props => [productId];
}
