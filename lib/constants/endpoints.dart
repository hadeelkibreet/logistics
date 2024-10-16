class Endpoints {
  static String baseURL = "https://dashboard.alnco.co";

  /// Auth
  static String login = "$baseURL/api/login";
  static String getProfile = "$baseURL/api/user";
  static String getStatue = "$baseURL/api/user";
  static String getRequests = "$baseURL/api/getRequests";
  static String startMission = "$baseURL/api/startMission";
  static String reject = "$baseURL/api/reject";
  static String postSenderSig = "$baseURL/api/validateStep";
  static String ReasonsRejection = "$baseURL/api/reasons-rejection";
  static String PostArrived = "$baseURL/api/arrived";

// static String getBooks(int id) => "$baseURL/api/library/books/$id";
}
