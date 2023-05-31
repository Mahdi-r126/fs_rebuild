class UserModels{
  String? id;
  String? userId;
  String? createdAt;
  String? phoneNumber;
  int? wallet;
  List<String>? roles;

  UserModels({this.id, this.userId, this.createdAt, this.phoneNumber, this.wallet, this.roles});

  UserModels.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["userId"];
    createdAt = json["createdAt"];
    phoneNumber = json["phoneNumber"];
    wallet = json["wallet"];
    roles = json["roles"] == null ? null : List<String>.from(json["roles"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["userId"] = userId;
    _data["createdAt"] = createdAt;
    _data["phoneNumber"] = phoneNumber;
    _data["wallet"] = wallet;
    if(roles != null) {
      _data["roles"] = roles;
    }
    return _data;
  }
}