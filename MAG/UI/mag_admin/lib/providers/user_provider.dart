import 'dart:convert';

import 'package:mag_admin/models/registration_data.dart';
import 'package:mag_admin/providers/base_provider.dart';

import '../models/user.dart';

class UserProvider extends BaseProvider<User> {
  final String _endpoint = "User";
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }

  Future<List<UserRegistrationData>> getUserRegistrations(int days) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/GetUserRegistrations/$days";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      List<UserRegistrationData> result = [];

      for (var item in data) {
        result.add(UserRegistrationData(
            date: DateTime.parse(item["dateJoined"]),
            numberOfUsers: item["numberOfUsers"]));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}
