class UserDataModel {
  String name;
  String phoneNumber;
  String email;
  String password;
  String conformPassword;

  UserDataModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.conformPassword,
  });

  factory UserDataModel.fromMap({required Map<String, dynamic> data}) {
    return UserDataModel(
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      password: data['password'],
      conformPassword: data['conformPassword'],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'conformPassword': conformPassword,
    };
  }
}
