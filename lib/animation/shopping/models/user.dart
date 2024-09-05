class User {
  final String name;
  final String email;
  final int id; // Add this line
  User({required this.name, required this.email, required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      id: json['id'], // Add this line
    );
  }
}
