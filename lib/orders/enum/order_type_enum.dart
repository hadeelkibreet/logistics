enum OrderType {
  all,
  loading,
  delivery,
  schedule;

  static OrderType fromString(String value) {
    late OrderType orderType;
    switch (value) {
      case 'all':
        orderType = OrderType.all;
        break;
      case 'loading':
        orderType = OrderType.loading;
        break;
      case 'delivery':
        orderType = OrderType.delivery;
        break;
      case 'schedule':
        orderType = OrderType.schedule;
        break;
      default:
        orderType = OrderType.all;
    }
    return orderType;
  }
}
