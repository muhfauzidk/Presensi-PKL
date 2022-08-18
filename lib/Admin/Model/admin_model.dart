class Admin {
  String? uid;
  String? email;
  String? name;
  String? kategori;
  // String? alamat;
  String? role;

  Admin({
    this.uid = '',
    this.email,
    this.name,
    this.kategori,
    // this.alamat,
    this.role,
  });

  // receiving data from server
  factory Admin.fromMap(map) {
    return Admin(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      kategori: map['kategori'],
      // alamat: map['alamat'],
      role: map['role'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'kategori': kategori,
      // 'alamat': alamat,
      'role': role,
    };
  }

  Map<String, dynamic> toJson() => {
      'uid': uid,
      'email': email,
      'name': name,
      'kategori': kategori,
      // 'alamat': alamat,
      'role': role,
  };

  static Admin fromJson(Map<String, dynamic> json) => Admin(
    uid: json['uid'],
    email: json['email'],
    name: json['name'],
    kategori: json['kategori'],
    // alamat: json['alamat'],
    role: json['role'],
  );
}