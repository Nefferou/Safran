class UserDto {
  final String id;
  final String name;
  final String email;
  final String password;

  UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}
