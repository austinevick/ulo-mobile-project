class Cities {
  final int id;
  final String name;
  Cities({
    this.id,
    this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Cities.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cities(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  String toString() => 'Cities(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cities && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
