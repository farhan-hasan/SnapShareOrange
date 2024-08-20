class UserInfoModel {
  final String id;
  final String name;
  final String email;
  final int followers;
  final int following;

  UserInfoModel({required this.id, required this.name, required this.email,required this.followers,required this.following});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'followers': followers,
      'following': following,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> userDetails) {
    return UserInfoModel(
      id: userDetails['id'],
      name: userDetails['name'],
      email: userDetails['email'],
      followers: userDetails['followers'],
      following: userDetails['following'],
    );
  }
}
