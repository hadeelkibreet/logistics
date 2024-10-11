import 'package:logistics/orders/enum/order_status_enum.dart';

class OrdersEntity {
  final int id;
  final String barcode;
  final String? ref;
  final String sourceName;
  final String sourceAddress;
  final String sourceNumberPhone;
  final String sourceLatitude;
  final String sourceLongitude;
  final String destinationName;
  final String destinationAddress;
  final String destinationNumberPhone;
  final String containerType;
  final int quantity; // Ensure this is defined as int
  final double weight; // Assuming weight might be a double
  final double cod; // Assuming cod might be a double
  final String deliveryZone;
  final String status;
  final int priority; // Ensure this is defined as int
  final DateTime deliveryTime;
  final DateTime assignmentDate;
  final String? notice;
  final String? commentStep1;
  final String? validation1Image;
  final String? validation1Signature;
  final DateTime? validationDateStep1;
  final String? commentStep2;
  final String? validation2Image;
  final String? validation2Signature;
  final DateTime? validationDateStep2;
  final DateTime? startTime;
  final String?
      started; // If started is a string, it should be declared as String
  final String type;
  final String driverId;

  OrdersEntity({
    required this.id,
    required this.barcode,
    this.ref,
    required this.sourceName,
    required this.sourceAddress,
    required this.sourceNumberPhone,
    required this.sourceLatitude,
    required this.sourceLongitude,
    required this.destinationName,
    required this.destinationAddress,
    required this.destinationNumberPhone,
    required this.containerType,
    required this.quantity,
    required this.weight,
    required this.cod,
    required this.deliveryZone,
    required this.status,
    required this.priority,
    required this.deliveryTime,
    required this.assignmentDate,
    this.notice,
    this.commentStep1,
    this.validation1Image,
    this.validation1Signature,
    this.validationDateStep1,
    this.commentStep2,
    this.validation2Image,
    this.validation2Signature,
    this.validationDateStep2,
    this.startTime,
    this.started,
    required this.type,
    required this.driverId,
  });

  factory OrdersEntity.fromJson(Map<String, dynamic> json) {
    return OrdersEntity(
      id: json['id'],
      barcode: json['barcode'],
      ref: json['ref'],
      sourceName: json['source_name'],
      sourceAddress: json['source_address'],
      sourceNumberPhone: json['source_number_phone'],
      sourceLatitude: json['source_latitude'],
      sourceLongitude: json['source_longitude'],
      destinationName: json['destination_name'],
      destinationAddress: json['destination_address'],
      destinationNumberPhone: json['destination_number_phone'],
      containerType: json['ContainerType'],
      quantity: int.parse(
          json['quantity'].toString()), // Convert to int if it's a String
      weight: double.parse(
          json['weight'].toString()), // Convert to double if it's a String
      cod: double.parse(
          json['cod'].toString()), // Convert to double if it's a String
      deliveryZone: json['DeliveryZone'],
      status: json['status'],
      priority: int.parse(
          json['priority'].toString()), // Convert to int if it's a String
      deliveryTime: DateTime.parse(json['delivery_time']),
      assignmentDate: DateTime.parse(json['assignment_date']),
      notice: json['notice'],
      commentStep1: json['comment_step1'],
      validation1Image: json['validation1_image'],
      validation1Signature: json['validation1_signature'],
      validationDateStep1: json['validation_date_step1'] != null
          ? DateTime.parse(json['validation_date_step1'])
          : null,
      commentStep2: json['comment_step2'],
      validation2Image: json['validation2_image'],
      validation2Signature: json['validation2_signature'],
      validationDateStep2: json['validation_date_step2'] != null
          ? DateTime.parse(json['validation_date_step2'])
          : null,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      started: json['started'].toString(), // If started is a string
      type: json['type'],
      driverId: json['driver_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barcode': barcode,
      'ref': ref,
      'source_name': sourceName,
      'source_address': sourceAddress,
      'source_number_phone': sourceNumberPhone,
      'source_latitude': sourceLatitude,
      'source_longitude': sourceLongitude,
      'destination_name': destinationName,
      'destination_address': destinationAddress,
      'destination_number_phone': destinationNumberPhone,
      'ContainerType': containerType,
      'quantity': quantity,
      'weight': weight,
      'cod': cod,
      'DeliveryZone': deliveryZone,
      'status': status,
      'priority': priority,
      'delivery_time': deliveryTime,
      'assignment_date': assignmentDate,
      'notice': notice,
      'comment_step1': commentStep1,
      'validation1_image': validation1Image,
      'validation1_signature': validation1Signature,
      'validation_date_step1': validationDateStep1,
      'comment_step2': commentStep2,
      'validation2_image': validation2Image,
      'validation2_signature': validation2Signature,
      'validation_date_step2': validationDateStep2,
      'start_time': startTime,
      'started': started,
      'type': type,
      'driver_id': driverId,
    };
  }

  OrderStatus get orderStatus {
    switch (status) {
      case 'Delivery_Rejected':
        return OrderStatus.Delivery_Rejected;
      case 'out_for_pickup':
        return OrderStatus.notTry;
      case 'in_sorting_facility':
        return OrderStatus.tryy;

      // Add other cases as needed
      default:
        throw Exception('Unknown status: $status');
    }
  }
}

// import 'package:logistics/orders/enum/order_status_enum.dart';
//
// class OrdersEntity {
//   final int id;
//   final String barcode;
//   final String ref;
//   final String sourceName;
//   final String sourceAddress;
//   final String sourceNumberPhone;
//   final String sourceLatitude;
//   final String sourceLongitude;
//   final String destinationName;
//   final String destinationAddress;
//   final String destinationNumberPhone;
//   final String containerType;
//   final int quantity;
//   final int weight;
//   final int cod;
//   final String deliveryZone;
//   final String status;
//   final int priority;
//   final String deliveryTime;
//   final String assignmentDate;
//   final String? notice;
//   final String? commentStep1;
//   final String? validation1Image;
//   final String? validation1Signature;
//   final String? validationDateStep1;
//   final String? commentStep2;
//   final String? validation2Image;
//   final String? validation2Signature;
//   final String? validationDateStep2;
//   final String? startTime;
//   final String? started;
//   final String type;
//   final String driverId;
//   OrdersEntity({
//     required this.id,
//     required this.barcode,
//     required this.ref,
//     required this.sourceName,
//     required this.sourceAddress,
//     required this.sourceNumberPhone,
//     required this.sourceLatitude,
//     required this.sourceLongitude,
//     required this.destinationName,
//     required this.destinationAddress,
//     required this.destinationNumberPhone,
//     required this.containerType,
//     required this.quantity,
//     required this.weight,
//     required this.cod,
//     required this.deliveryZone,
//     required this.status,
//     required this.priority,
//     required this.deliveryTime,
//     required this.assignmentDate,
//     this.notice,
//     this.commentStep1,
//     this.validation1Image,
//     this.validation1Signature,
//     this.validationDateStep1,
//     this.commentStep2,
//     this.validation2Image,
//     this.validation2Signature,
//     this.validationDateStep2,
//     this.startTime,
//     this.started,
//     required this.type,
//     required this.driverId,
//   });
//
//   factory OrdersEntity.fromJson(Map<String, dynamic> json) {
//     return OrdersEntity(
//       id: json['id'],
//       barcode: json['barcode'],
//       ref: json['ref'],
//       sourceName: json['source_name'],
//       sourceAddress: json['source_address'],
//       sourceNumberPhone: json['source_number_phone'],
//       sourceLatitude: json['source_latitude'],
//       sourceLongitude: json['source_longitude'],
//       destinationName: json['destination_name'],
//       destinationAddress: json['destination_address'],
//       destinationNumberPhone: json['destination_number_phone'],
//       containerType: json['ContainerType'],
//       quantity: json['quantity'],
//       weight: json['weight'],
//       cod: json['cod'],
//       deliveryZone: json['DeliveryZone'],
//       status: json['status'],
//       priority: json['priority'],
//       deliveryTime: json['delivery_time'],
//       assignmentDate: json['assignment_date'],
//       notice: json['notice'],
//       commentStep1: json['comment_step1'],
//       validation1Image: json['validation1_image'],
//       validation1Signature: json['validation1_signature'],
//       validationDateStep1: json['validation_date_step1'],
//       commentStep2: json['comment_step2'],
//       validation2Image: json['validation2_image'],
//       validation2Signature: json['validation2_signature'],
//       validationDateStep2: json['validation_date_step2'],
//       startTime: json['start_time'],
//       started: json['started'],
//       type: json['type'],
//       driverId: json['driver_id'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'barcode': barcode,
//       'ref': ref,
//       'source_name': sourceName,
//       'source_address': sourceAddress,
//       'source_number_phone': sourceNumberPhone,
//       'source_latitude': sourceLatitude,
//       'source_longitude': sourceLongitude,
//       'destination_name': destinationName,
//       'destination_address': destinationAddress,
//       'destination_number_phone': destinationNumberPhone,
//       'ContainerType': containerType,
//       'quantity': quantity,
//       'weight': weight,
//       'cod': cod,
//       'DeliveryZone': deliveryZone,
//       'status': status,
//       'priority': priority,
//       'delivery_time': deliveryTime,
//       'assignment_date': assignmentDate,
//       'notice': notice,
//       'comment_step1': commentStep1,
//       'validation1_image': validation1Image,
//       'validation1_signature': validation1Signature,
//       'validation_date_step1': validationDateStep1,
//       'comment_step2': commentStep2,
//       'validation2_image': validation2Image,
//       'validation2_signature': validation2Signature,
//       'validation_date_step2': validationDateStep2,
//       'start_time': startTime,
//       'started': started,
//       'type': type,
//       'driver_id': driverId,
//     };
//   }
//
//   OrderStatus get orderStatus {
//     switch (status) {
//       case 'Delivery_Rejected':
//         return OrderStatus.Delivery_Rejected;
//       case 'in_sorting_facility':
//         return OrderStatus.allOrders;
//       // Add other cases as needed
//       default:
//         throw Exception('Unknown status: $status');
//     }
//   }
// }
