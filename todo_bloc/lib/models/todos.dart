import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todos extends Equatable {
  final String id;
  String name;
  bool isComplete;
  String? notes;

  Todos({
    required this.id,
    required this.name,
    required this.isComplete,
    this.notes,
  });

  Todos copyWith({
    String? name,
    bool? isComplete,
    String? notes,
  }) {
    return Todos(
      id: id,
      name: name ?? this.name,
      isComplete: isComplete ?? this.isComplete,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [id, name, isComplete, notes];
}
