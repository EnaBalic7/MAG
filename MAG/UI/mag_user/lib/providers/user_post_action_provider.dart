import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_post_action.dart';
import '../providers/base_provider.dart';
import '../utils/util.dart';

class UserPostActionProvider extends BaseProvider<UserPostAction> {
  final String _endpoint = "UserPostAction";
  UserPostActionProvider() : super("UserPostAction");

  @override
  UserPostAction fromJson(data) {
    return UserPostAction.fromJson(data);
  }

  Future<void> saveUserAction(int postId, String action) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('post_$postId', action);

    await _sendUserActionToServer(postId, action);
  }

  Future<String?> getUserAction(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('post_$postId');
  }

  Future<void> _sendUserActionToServer(int postId, String action) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/action/$postId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      "action": action,
      "userId": LoggedUser.user!.id,
      "postId": postId,
    });
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      notifyListeners();
    } else {
      throw Exception("Unknown error");
    }
  }
}
