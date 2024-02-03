class FirebaseUserModel {
  final String uid;
  final String email;
  final bool emailVerified;

  FirebaseUserModel({
    required this.uid,
    required this.email,
    required this.emailVerified,
  });
}
