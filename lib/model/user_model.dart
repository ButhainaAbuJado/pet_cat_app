class UserModel {
  static UserModel shared = UserModel._privateConstructor(
    userId: "",
    username: "",
    email: "",
    createdDate: "",
    lastSignedIn: "",
    imageUrl: ""
  );

  String userId;
  String username;
  String email;
  String createdDate;
  String lastSignedIn;
  String imageUrl;

  UserModel._privateConstructor({
    required this.userId,
    required this.username,
    required this.email,
    required this.createdDate,
    required this.lastSignedIn,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'User{id: $userId, username: $username, email: $email, createdDate: $createdDate, lastSignedIn: $lastSignedIn, imageUrl: $imageUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          username == other.username &&
          email == other.email &&
          createdDate == other.createdDate &&
          lastSignedIn == other.lastSignedIn &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      userId.hashCode ^
      username.hashCode ^
      email.hashCode ^
      createdDate.hashCode ^
      lastSignedIn.hashCode ^
      imageUrl.hashCode;
}
