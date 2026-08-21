class Users {
  static const String collectionName = 'users';

  String id;
  String name;
  String email;
  String phone;
  String image;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  Map<String, dynamic> toFirebaseStore() {
    return {
      'uid': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }

  Users.fromFirebaseStore(Map<String, dynamic> data)
      : this(
    id: data['uid'] ?? '',
    name: data['name'] ?? '',
    email: data['email'] ?? '',
    phone: data['phone'] ?? '',
    image: data['image'] ?? '',
  );
}