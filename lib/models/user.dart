class FirebaseUser{


  FirebaseUser copyWith({
    String? email,
  }) {
    return FirebaseUser(
      email: email ?? this.email,
    );
  }

  final String email;


  const FirebaseUser({
    required this.email,
  });


  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
    };
  }
  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      email: map['email'] as String,
    );
  }}
