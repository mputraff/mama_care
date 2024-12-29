class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? token;
  String profilePicture;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
    this.token,
    required this.profilePicture,
    
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: '', // Password tidak perlu disimpan setelah login
      token: json['token'], 
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'profilePicture': profilePicture,
    };
  }
}
