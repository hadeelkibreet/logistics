class TooManyRequests implements Exception {
  final String message;

  TooManyRequests(this.message);

  @override
  String toString() {
    return 'MyCustomException: $message';
  }
}
