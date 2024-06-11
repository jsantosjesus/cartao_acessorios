class UserSharedModel {
  final String email;
  final String password;

  UserSharedModel({required this.email, required this.password});

  factory UserSharedModel.fromMap(Map<String, dynamic> map) {
    return UserSharedModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
