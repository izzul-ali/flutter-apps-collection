part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsStateInitial extends ProductsState {}

// loading state
final class ProductsStateLoadingGetOne extends ProductsState {}

final class ProductsStateLoadingAdd extends ProductsState {}

final class ProductsStateLoadingUpdate extends ProductsState {}

final class ProductsStateLoadingDelete extends ProductsState {}

// complete state
final class ProductsStateCompleteGetOne extends ProductsState {
  final Product product;

  const ProductsStateCompleteGetOne({required this.product});

  @override
  List<Object> get props => [product];
}

final class ProductsStateCompleteUpdate extends ProductsState {}

final class ProductsStateCompleteDelete extends ProductsState {}

final class ProductsStateCompleteAdd extends ProductsState {
  final List<Product> products;

  const ProductsStateCompleteAdd({this.products = const []});

  @override
  List<Object> get props => [products];
}

// error state
final class ProductsStateErrorAdd extends ProductsState {
  final String message;

  const ProductsStateErrorAdd({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProductsStateErrorGetOne extends ProductsStateErrorAdd {
  const ProductsStateErrorGetOne({required super.message});
}

final class ProductsStateErrorUpdate extends ProductsStateErrorAdd {
  const ProductsStateErrorUpdate({required super.message});
}

final class ProductsStateErrorDelete extends ProductsStateErrorAdd {
  const ProductsStateErrorDelete({required super.message});
}
