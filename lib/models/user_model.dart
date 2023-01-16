// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.password,
    this.genre,
    this.isAdmin,
  });

  int? id;
  String? name;
  String? password;
  String? genre;
  bool? isAdmin;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        password: json["password"] == null ? null : json["password"],
        genre: json["genre"] == null ? null : json["genre"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id == null ? null : id,
      "name": name == null ? null : name,
      "password": password == null ? null : password,
      "genre": genre == null ? null : genre,
      "isAdmin": isAdmin == null ? null : isAdmin,
    };
  }
}
