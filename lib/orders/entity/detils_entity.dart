class DetilsEntity {
  int id;
  String barcode;
  String ref;
  String sourceName;
  String sourceAddress;
  String sourceNumberPhone;
  String sourceLatitude;
  String sourceLongitude;
  String destinationName;
  String destinationAddress;
  String destinationNumberPhone;
  String containerType;
  int quantity;
  int weight;
  int cod;
  String deliveryZone;
  String status;
  String priority;
  String deliveryTime;
  String assignmentDate;
  dynamic notice;
  dynamic commentStep1;
  dynamic validation1Image;
  dynamic validation1Signature;
  dynamic validationDateStep1;
  dynamic commentStep2;
  dynamic validation2Image;
  dynamic validation2Signature;
  dynamic validationDateStep2;
  String startTime;
  int started;
  String type;
  int driverId;

  DetilsEntity({
    required this.id,
    required this.barcode,
    required this.ref,
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
    required this.startTime,
    required this.started,
    required this.type,
    required this.driverId,
  });

  factory DetilsEntity.fromJson(Map<String, dynamic> json) {
    return DetilsEntity(
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
      quantity: json['quantity'],
      weight: json['weight'],
      cod: json['cod'],
      deliveryZone: json['DeliveryZone'],
      status: json['status'],
      priority: json['priority'],
      deliveryTime: json['delivery_time'],
      assignmentDate: json['assignment_date'],
      notice: json['notice'],
      commentStep1: json['comment_step1'],
      validation1Image: json['validation1_image'],
      validation1Signature: json['validation1_signature'],
      validationDateStep1: json['validation_date_step1'],
      commentStep2: json['comment_step2'],
      validation2Image: json['validation2_image'],
      validation2Signature: json['validation2_signature'],
      validationDateStep2: json['validation_date_step2'],
      startTime: json['start_time'],
      started: json['started'],
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
}
