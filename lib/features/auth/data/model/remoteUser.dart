class RemoteUser {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? avatarPath;

  RemoteUser({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatarPath,
  });

  factory RemoteUser.fromJson(Map<String, dynamic> json) {
    return RemoteUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      avatarPath: json['avatarPath'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'avatarPath': avatarPath,
    }..removeWhere((key, value) => value == null); // optional: remove null fields
  }
}