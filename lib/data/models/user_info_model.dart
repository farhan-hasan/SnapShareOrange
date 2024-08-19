class UserInfoModel {
  final String id;
  final String name;
  final String email;

  UserInfoModel({required this.id, required this.name, required this.email});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> userDetails) {
    return UserInfoModel(
      id: userDetails['id'],
      name: userDetails['name'],
      email: userDetails['email'],
    );
  }
}
