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
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.emailAddress == emailAddress &&
        o.avatarUrl == avatarUrl &&
        o.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        emailAddress.hashCode ^
        avatarUrl.hashCode ^
        isAdmin.hashCode;
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, emailAddress: $emailAddress, avatarUrl: $avatarUrl, isAdmin: $isAdmin)';
  }
}
