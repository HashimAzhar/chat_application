class UserModel {
  final String uid;
  final String name;
  final String email;
  final String username;
  final String photoUrl;
  final String about;
  final bool isOnline;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.photoUrl,
    required this.about,
    required this.isOnline,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      about: map['about'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }
}
