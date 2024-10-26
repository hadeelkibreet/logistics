enum OrderType {
  all,
  loading,
  delivery;

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
      default:
        orderType = OrderType.all;
    }
    return orderType;
  }
}
