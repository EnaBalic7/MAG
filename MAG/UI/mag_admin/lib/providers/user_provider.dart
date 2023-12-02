import 'package:mag_admin/providers/base_provider.dart';

import '../models/user.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }
}
