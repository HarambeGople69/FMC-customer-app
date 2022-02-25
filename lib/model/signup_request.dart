class SignUpRequestModel {
  String full_name;
  String email_address;
  String mobile_no;
  String username;
  String password;

  SignUpRequestModel({
    required this.full_name,
    required this.email_address,
    required this.mobile_no,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'full_name': full_name,
      'email_address': email_address,
      'mobile_no': mobile_no,
      'username': username,
      'password': password,
    };

    return map;
  }
}
