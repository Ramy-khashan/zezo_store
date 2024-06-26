class EndPoints {
  static const String authBaseUrl =
      "https://identitytoolkit.googleapis.com/v1/";
  static const String apiKey = "AIzaSyAxzwebvAijsF8HCq-QE_pIRZlbPa1RjMw";
  static const String signIn =
      "${authBaseUrl}accounts:signInWithPassword?key=$apiKey";
  static const String forgetPassword =
      "${authBaseUrl}accounts:sendOobCode?key=$apiKey";  static const String resetPassword =
      "${authBaseUrl}accounts:update?key=$apiKey"; 

  static const String signUp = "${authBaseUrl}accounts:signUp?key=$apiKey";
  static const String signGoogle =
      "${authBaseUrl}accounts:signInWithIdp?key=$apiKey";

  static const String firestoreBaseUrl =
      "https://firestore.googleapis.com/v1/projects/$firebaseProjectId/databases/(default)/documents";
  static const String firebaseProjectId = 'zezo-store-32084';
  static const String baseUrlPayment = 'https://accept.paymob.com/api/';
  static const String authToken = '${baseUrlPayment}auth/tokens';
  static const String paymentOrder = '${baseUrlPayment}ecommerce/orders';
  static const String paymentToken = '${baseUrlPayment}acceptance/payment_keys';
  static const int integrationID =2081134;
  static const int iFrameID =384537;
     
  static const String apiToken =
      'ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNklqRTJOemd6TVRBNU56a3VPRGsxT1RRMklpd2ljSEp2Wm1sc1pWOXdheUk2TVRjMU5qUXlmUS4yZF8xYTRnYl8ycU9nQThMZm9vNjJBQ1JIQ2JJdlNTRjl2YzdmLUFYOUtvVk90eXhPSmlWdkJITnEzWDFfWVV2XzFSOFNQTUtkdUxTS1hoVkdTX0tPUQ==';
}