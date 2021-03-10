class User {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String avatarUrl;
  bool isAdmin;
  User({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.avatarUrl,
    this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'avatarUrl': avatarUrl,
      'isAdmin': isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      emailAddress: map['email'],
      avatarUrl: map['avatarUrl'],
      isAdmin: map['isAdmin'],
    );
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, emailAddress: $emailAddress, avatarUrl: $avatarUrl, isAdmin: $isAdmin)';
  }
}
