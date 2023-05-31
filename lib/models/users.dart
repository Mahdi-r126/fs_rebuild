import 'package:freesms/models/user.dart';

class Users {
  List<User> users;
  int totalItems;

  Users({required this.users, required this.totalItems});

  factory Users.fromJson(Map<String, dynamic> json) {
    List<User> usersList = List<User>.from(json['users'].map((item) => User.fromJson(item)).toList());
    var users = usersList;
    var totalItems = json['totalItems'];
    return Users(users: users, totalItems: totalItems);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from({
      'users': users,
      'totalItems': totalItems,
    });
  }
}