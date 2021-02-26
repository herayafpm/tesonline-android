import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  int user_id;
  @HiveField(1)
  String user_username;
  @HiveField(2)
  String user_nama;
  @HiveField(3)
  String user_email;
  @HiveField(4)
  int role_id;
  @HiveField(5)
  String role_nama;
  @HiveField(6)
  String token;
  @HiveField(7)
  bool is_admin;
  String user_password;

  UserModel(
      {this.user_id = 0,
      this.user_username = "",
      this.user_nama = "",
      this.user_email = "",
      this.role_id = 0,
      this.role_nama = "",
      this.token = "",
      this.is_admin = false,
      this.user_password = ""});

  factory UserModel.createFromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: int.parse(json['user_id']),
      user_username: json['user_username'],
      user_nama: json['user_nama'],
      user_email: json['user_email'],
      role_id: int.parse(json['role_id']),
      role_nama: json['role_nama'],
      token: json['token'],
      is_admin: json['is_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_username'] = this.user_username;
    data['user_nama'] = this.user_nama;
    data['user_email'] = this.user_email;
    data['user_password'] = this.user_password;
    return data;
  }
}
