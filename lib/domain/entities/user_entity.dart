class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String phone;

  UserEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'name': name,
        'phone': phone,
      };

  factory UserEntity.fromMap(Map<String, dynamic> m) => UserEntity(
        uid: m['uid'] as String,
        email: m['email'] as String,
        name: m['name'] as String,
        phone: m['phone'] as String,
      );
}
