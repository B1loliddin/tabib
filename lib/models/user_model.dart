enum Gender { male, female }

class UserModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  DateTime dateOfBirth;
  int height;
  double weight;
  Gender gender;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      height: json['height'] as int,
      weight: (json['weight'] as num).toDouble(),
      gender: Gender.values
          .firstWhere((e) => e.toString() == 'Gender.${json['gender']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'height': height,
      'weight': weight,
      'gender': gender.toString().split('.').last,
    };
  }
}
