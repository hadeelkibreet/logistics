import 'package:equatable/equatable.dart';
import 'package:logistics/orders/entity/orders_entity.dart';

class PositionedOrderEntity extends Equatable {
  const PositionedOrderEntity({
    required this.orders,
    required this.destinationName,
    required this.position,
  });

  final List<OrdersEntity> orders;
  final String destinationName;
  final int position;

  @override
  List<Object?> get props => [
        orders,
        destinationName,
        position,
      ];
}
