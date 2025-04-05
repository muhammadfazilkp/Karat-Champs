class LoginResponse {
  final String message;
  final String homePage;
  final String fullName;
  final KeyDetails keyDetails;
  final UserDetails userDetails;

  LoginResponse({
    required this.message,
    required this.homePage,
    required this.fullName,
    required this.keyDetails,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      homePage: json['home_page'],
      fullName: json['full_name'],
      keyDetails: KeyDetails.fromJson(json['key_details']),
      userDetails: UserDetails.fromJson(json['user_details']),
    );
  }
}

class KeyDetails {
  final String apiKey;
  final String apiSecret;

  KeyDetails({
    required this.apiKey,
    required this.apiSecret,
  });

  factory KeyDetails.fromJson(Map<String, dynamic> json) {
    return KeyDetails(
      apiKey: json['api_key'],
      apiSecret: json['api_secret'],
    );
  }
}

class UserDetails {
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String? mobileNo;
  final String? gender;
  final String? roleProfileName;
  final int enabled;

  UserDetails({
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.mobileNo,
    this.gender,
    this.roleProfileName,
    required this.enabled,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      gender: json['gender'],
      roleProfileName: json['role_profile_name'],
      enabled: json['enabled'],
    );
  }
}
