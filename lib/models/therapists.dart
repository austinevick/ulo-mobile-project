class Therapists {
  final int id;
  final String name;
  final String avatar;
  final String emailAddress;
  final String phone;
  final String credentials;
  final List<String> desc;
  final List<DefaultAvailability> defaultAvailability;
  final List<DailyAvailability> dailyAvailability;
  Therapists({
    this.id,
    this.name,
    this.avatar,
    this.emailAddress,
    this.phone,
    this.credentials,
    this.desc,
    this.defaultAvailability,
    this.dailyAvailability,
  });

  factory Therapists.fromMap(Map<String, dynamic> map) {
    List<String> description;
    List<DefaultAvailability> defaultAvailability;
    map['defaultAvailability'].forEach(
        (map) => defaultAvailability.add(DefaultAvailability.fromMap(map)));
    map['description'].forEach((map) => description.add(map));

    return Therapists(
        id: map['id'],
        name: map['name'],
        avatar: map['avatar'],
        emailAddress: map['emailAddress'],
        phone: map['phone'],
        credentials: map['credentials'],
        desc: description,
        defaultAvailability: defaultAvailability);
  }

  @override
  String toString() {
    return 'Therapists(id: $id, name: $name, avatar: $avatar, emailAddress: $emailAddress, phone: $phone, credentials: $credentials, desc: $desc, defaultAvailability: $defaultAvailability, dailyAvailability: $dailyAvailability)';
  }
}

class DefaultAvailability {
  final int key;
  final String displayValue;

  DefaultAvailability({this.key, this.displayValue});

  factory DefaultAvailability.fromMap(Map<String, dynamic> map) {
    return DefaultAvailability(
        displayValue: map['displayValue'], key: map['key']);
  }

  @override
  String toString() =>
      'DefaultAvailability(key: $key, displayValue: $displayValue)';
}

class DailyAvailability {
  final List<String> dailyAvailability;
  DailyAvailability({
    this.dailyAvailability,
  });

  factory DailyAvailability.fromMap(Map<String, dynamic> map) {
    List<DailyAvailability> availabilityTime = [];
    // map['dailyAvailability']['1571889600000'].forEach((map)=>)
    return DailyAvailability();
  }

  @override
  String toString() => 'DailyAvailability(time: $dailyAvailability)';
}
