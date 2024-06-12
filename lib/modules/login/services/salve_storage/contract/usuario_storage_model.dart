class UserStorageModel {
  final String email;
  final String password;

  UserStorageModel({required this.email, required this.password});

  factory UserStorageModel.fromMap(Map<String, dynamic> map) {
    return UserStorageModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
