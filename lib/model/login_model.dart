class LoginModel {
  LoginModel({
    this.token,
    this.data,
  });

  String? token;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.login,
    this.about,
  });

  Login? login;
  About? about;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        login: Login.fromJson(json["login"]),
        about: About.fromJson(json["about"]),
      );

  Map<String, dynamic> toJson() => {
        "login": login!.toJson(),
        "about": about!.toJson(),
      };
}

class About {
  About({
    this.title,
    this.name,
    this.version,
    this.description,
  });

  String? title;
  String? name;
  String? version;
  String? description;

  factory About.fromJson(Map<String, dynamic> json) => About(
        title: json["title"],
        name: json["name"],
        version: json["version"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
        "version": version,
        "description": description,
      };
}

class Login {
  Login({
    this.id,
    this.name,
    this.store,
    this.phone,
  });

  int? id;
  String? name;
  String? store;
  String? phone;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
        name: json["name"],
        store: json["store"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "store": store,
        "phone": phone,
      };
}
