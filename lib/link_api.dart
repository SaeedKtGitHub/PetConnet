class AppLink {
  static String server = "http://10.0.2.2:8012/ecommerce";
  static String test = "$server/test.php";

  //Auth
  static String signUp = "$server/auth/signup.php";
  static String login = "$server/auth/login.php";
  static String verifyCodeSignUp = "$server/auth/verfiycode.php";

  //FORGET PASSWORD
  static String checkEmail = "$server/forgetpassword/checkemail.php";
  static String resetPassword = "$server/forgetpassword/resetpassword.php";
  static String verifyCodeForgetPassword =
      "$server/forgetpassword/verifycode.php";
}
